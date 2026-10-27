-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.bookGfTerm_eq
import Mathlib
import Theorems.Thm_BookProof_BookBrstGaugeFixing_brstCharge_gf_anticomm
import Theorems.Thm_BookProof_BookBrstYangMills_Afield_comm_chi
import Theorems.Thm_BookProof_BookBrstYangMills_bookConstraintAlgebra
import Theorems.Thm_BookProof_BookBrstYangMills_bookGhostCar
import Theorems.Thm_BookProof_BookBrstYangMills_bookOmega_eq_brstCharge
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_ghostOpN_comm
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution :
    bookGfTerm G
      = -((∑ c, gaussGen G c * Afield 0 c)
          - (∑ c, ∑ d, (gaussGen G c * Afield 0 d - Afield 0 d * gaussGen G c)
              * (betaOp d * chiOp c))
          - ∑ a, ∑ b, ∑ c, G.f a b c • (Afield 0 a * (chiOp b * betaOp c))) := by

  have habs := brstCharge_gf_anticomm (f := G.f) (Gc := gaussGen G) (χ := chiOp)
    (β := betaOp) (B := fun a => Afield (N := N) 0 a) bookGhostCar G.antisymm
    (fun a b => (bookConstraintAlgebra G).comm_beta a b)
    (fun a b => Afield_comm_chi 0 a b)
    (fun a b => bosOpN_ghostOpN_comm _ _)
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  calc bookGfTerm G
      = (Complex.I * Complex.I) • (brstCharge G.f (gaussGen G) chiOp betaOp
            * gfFermion betaOp (fun a => Afield (N := N) 0 a)
          + gfFermion betaOp (fun a => Afield (N := N) 0 a)
            * brstCharge G.f (gaussGen G) chiOp betaOp) := by
        rw [bookGfTerm, bookGfFermion, bookOmega_eq_brstCharge, smul_mul_smul_comm,
          smul_mul_smul_comm, ← smul_add]
    _ = -(brstCharge G.f (gaussGen G) chiOp betaOp
            * gfFermion betaOp (fun a => Afield (N := N) 0 a)
          + gfFermion betaOp (fun a => Afield (N := N) 0 a)
            * brstCharge G.f (gaussGen G) chiOp betaOp) := by
        rw [hI, neg_one_smul]
    _ = _ := by rw [habs]
