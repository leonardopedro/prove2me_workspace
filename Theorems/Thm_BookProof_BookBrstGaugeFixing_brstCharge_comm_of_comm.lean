-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.brstCharge_comm_of_comm
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBookBrstYangMills
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterSmBrstGhost
open BookProof.BRSTNilpotent
open BookProof.SmBrstGhost
open BookProof.BookBrstGaugeFixing



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

theorem BookProof.BookBrstGaugeFixing.brstCharge_comm_of_comm {T : R} (hG : ∀ a, Gc a * T = T * Gc a)
    (hχ : ∀ a, χ a * T = T * χ a) (hβ : ∀ a, β a * T = T * β a) :
    brstCharge f Gc χ β * T = T * brstCharge f Gc χ β := by sorry
