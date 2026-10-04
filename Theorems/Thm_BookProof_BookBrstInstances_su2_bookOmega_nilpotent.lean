-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.su2_bookOmega_nilpotent
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.YangMillsGhost
open BookProof.BookBrstInstances

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)



open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section


theorem BookProof.BookBrstInstances.su2_bookOmega_nilpotent (x : Fin 4 → Fin 3 → ℝ) :
    bookOmega (su2BookAlgebra x) * bookOmega (su2BookAlgebra x) = 0 := by sorry
