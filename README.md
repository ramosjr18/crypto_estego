# 🛡️ CRYPTO_ENTREGO

Proyecto práctico de **Criptografía Aplicada y Esteganografía** desarrollado como entrega evaluable.  
Incluye implementaciones funcionales en **Bash y Python**, demostrando cifrado simétrico, cifrado autenticado y firma digital.

---

## 📖 Descripción general

Este proyecto muestra cómo aplicar principios fundamentales de la criptografía moderna en entornos reales:

| Módulo | Algoritmo principal | Propósito | Tecnología |
|:-------|:--------------------|:-----------|:------------|
| **P1** | AES-128-CBC + HMAC-SHA256 | Derivación y cifrado simétrico de archivos | Bash + OpenSSL |
| **P2** | AES-GCM (autenticado) | Cifrado con integridad y AAD (Python) | Bash / Python |
| **P3** | ECDSA (SHA-256, prime256v1) | Firma y verificación digital | Bash + OpenSSL |

Cada módulo se acompaña de scripts automatizados y ejemplos prácticos con datos de prueba.

---

## 🔐 Conceptos clave

| Término | Descripción |
|----------|-------------|
| **AES (Advanced Encryption Standard)** | Cifrado simétrico de bloque (128, 192 o 256 bits). |
| **CBC (Cipher Block Chaining)** | Encadena bloques y requiere IV único. |
| **GCM (Galois/Counter Mode)** | Cifrado autenticado (integra cifrado + integridad). |
| **HMAC-SHA256** | Hash con clave usada para derivación o verificación. |
| **ECDSA** | Firma digital basada en curvas elípticas. |
| **IV (Initialization Vector)** | Valor aleatorio que evita repeticiones. |
| **TAG** | Etiqueta de autenticación de 16 bytes en GCM. |
| **AAD** | Datos adicionales autenticados, no cifrados. |

---

## 🧠 Conclusión

Este proyecto demuestra los tres pilares de la seguridad de la información:

| Pilar | Ejemplo |
|-------|----------|
| **Confidencialidad** | AES-128-CBC / AES-GCM |
| **Integridad** | TAG, HMAC |
| **Autenticidad** | Firmas ECDSA |

La práctica refuerza el entendimiento de los modos de cifrado y autenticación, así como la gestión segura de claves y vectores de inicialización.  
También muestra cómo aplicar la teoría criptográfica tanto desde **scripts en Bash con OpenSSL** como en **Python** con bibliotecas modernas.

---

## 👤 Autor

**Daniel Ramos**  
Ciberseguridad & Desarrollo de Software  
📧 contacto: *ramosdarc-18@outlook.com*