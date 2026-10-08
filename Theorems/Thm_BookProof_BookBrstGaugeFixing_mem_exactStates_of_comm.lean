-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.mem_exactStates_of_comm
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBookBrstYangMills
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBrstReducedTransfer
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.BrstReducedTransfer
open BookProof.YangMillsGhost
open BookProof.BookBrstGaugeFixing



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

theorem BookProof.BookBrstGaugeFixing.mem_exactStates_of_comm {T : Module.End ℂ (BookState N)}
    (hG : ∀ a, gaussGen G a * T = T * gaussGen G a)
    (hχ : ∀ a, chiOp (N := N) a * T = T * chiOp a)
    (hβ : ∀ a, betaOp (N := N) a * T = T * betaOp a)
    {v : BookState N} (hv : v ∈ exactStates G) : T v ∈ exactStates G := by sorry
