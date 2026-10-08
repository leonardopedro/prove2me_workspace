-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.gaussGenPoly_comm_mulLeft
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBookBrstYangMills
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
open BookProof.BookBrstGaugeFixing



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

theorem BookProof.BookBrstGaugeFixing.gaussGenPoly_comm_mulLeft (c : Fin N) (p : FieldPoly N) :
    gaussGenPoly G c * LinearMap.mulLeft ℂ p - LinearMap.mulLeft ℂ p * gaussGenPoly G c
      = LinearMap.mulLeft ℂ (gaussDer G c p) := by sorry
