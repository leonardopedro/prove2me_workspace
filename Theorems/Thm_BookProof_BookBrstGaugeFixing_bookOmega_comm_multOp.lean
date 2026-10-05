-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.bookOmega_comm_multOp
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

theorem BookProof.BookBrstGaugeFixing.bookOmega_comm_multOp {p : FieldPoly N} (hp : ∀ c, gaussDer G c p = 0) :
    bookOmega G * multOp p = multOp p * bookOmega G := by sorry
