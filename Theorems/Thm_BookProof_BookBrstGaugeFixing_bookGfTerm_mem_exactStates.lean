-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.bookGfTerm_mem_exactStates
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

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.bookGfTerm_mem_exactStates {v : BookState N} (hv : v ∈ exactStates G) :
    bookGfTerm G v ∈ exactStates G := by sorry
