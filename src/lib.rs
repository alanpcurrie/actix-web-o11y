use actix_web::dev::Server;
use actix_web::{web, App, HttpResponse, HttpServer};
use actix_web_prom::PrometheusMetricsBuilder;
use std::net::TcpListener;

async fn health_check() -> HttpResponse {
    HttpResponse::Ok().finish()
}

pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {
    let prometheus = PrometheusMetricsBuilder::new("api")
        .endpoint("/metrics")
        .build()
        .unwrap();

    let server = HttpServer::new(move || {
        App::new()
            .wrap(prometheus.clone())
            .route("/health_check", web::get().to(health_check))
    })
    .listen(listener)?
    .run();
    Ok(server)
}
