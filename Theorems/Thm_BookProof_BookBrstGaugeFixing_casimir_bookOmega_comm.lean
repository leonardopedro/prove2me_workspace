-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.casimir_bookOmega_comm
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBookBrstYangMills
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.ChapterLinftyMultiplication
open BookProof.YangMillsGhost
open BookProof.BookBrstGaugeFixing

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.casimir_bookOmega_comm (hD : ∀ μ c a, G.D μ c a = 0) :
    bookOmega G * multOp (casimirPoly (N := N)) = multOp (casimirPoly (N := N)) * bookOmega G := by sorry
