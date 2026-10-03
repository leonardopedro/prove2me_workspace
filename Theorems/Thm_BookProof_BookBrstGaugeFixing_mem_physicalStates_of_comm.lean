-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.mem_physicalStates_of_comm
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBrstReducedTransfer
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.BrstReducedTransfer
open BookProof.YangMillsGhost

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}



open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.mem_physicalStates_of_comm {T : Module.End ℂ (BookState N)}
    (hG : ∀ a, gaussGen G a * T = T * gaussGen G a)
    (hχ : ∀ a, chiOp (N := N) a * T = T * chiOp a)
    (hβ : ∀ a, betaOp (N := N) a * T = T * betaOp a)
    {v : BookState N} (hv : v ∈ physicalStates G) : T v ∈ physicalStates G := by sorry
