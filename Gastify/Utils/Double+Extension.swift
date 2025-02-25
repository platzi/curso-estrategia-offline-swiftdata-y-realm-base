//
//  Double+Extension.swift
//  Gastify
//
//  Created by Santiago Moreno on 5/01/25.
//
import Foundation

extension Double {
    func toMoneyAmount() -> String {
        // Primero redondeamos a 2 decimales
        let numeroRedondeado = (self * 100).rounded() / 100

        // Casos especiales para números negativos o cero
        if numeroRedondeado == 0 {
            return "0"
        }

        let absNumero = abs(numeroRedondeado)
        let signo = numeroRedondeado < 0 ? "-" : ""

        switch absNumero {
        case 0..<9999:
            // Para números menores a 9999, mostramos el número completo
            // Si termina en .0, mostramos solo la parte entera
            if floor(absNumero) == absNumero {
                return signo + String(format: "%.0f", absNumero)
            } else {
                return signo + String(format: "%.2f", absNumero)
                    .replacingOccurrences(of: ".00", with: "")
            }

        case 9999..<999999:
            // Para números en miles (K)
            let miles = absNumero / 1000
            if floor(miles) == miles {
                return signo + String(format: "%.0fK", miles)
            } else {
                return signo + String(format: "%.1fK", miles)
                    .replacingOccurrences(of: ".0K", with: "K")
            }

        case 999999..<999999999:
            // Para números en millones (M)
            let millones = absNumero / 1000000
            if floor(millones) == millones {
                return signo + String(format: "%.0fM", millones)
            } else {
                return signo + String(format: "%.1fM", millones)
                    .replacingOccurrences(of: ".0M", with: "M")
            }

        default:
            // Para números en billones (B) o más grandes
            let billones = absNumero / 1000000000
            if floor(billones) == billones {
                return signo + String(format: "%.0fB", billones)
            } else {
                return signo + String(format: "%.1fB", billones)
                    .replacingOccurrences(of: ".0B", with: "B")
            }
        }
    }
}
