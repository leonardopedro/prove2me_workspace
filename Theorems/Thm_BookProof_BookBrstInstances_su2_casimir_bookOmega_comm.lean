-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.su2_casimir_bookOmega_comm
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.ChapterLinftyMultiplication
open BookProof.SmBrstGhost
open BookProof.YangMillsGhost
open BookProof.BookBrstInstances

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)



open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section


theorem BookProof.BookBrstInstances.su2_casimir_bookOmega_comm :
    bookOmega (su2BookAlgebra 0) * multOp (casimirPoly (N := 3))
      = multOp (casimirPoly (N := 3)) * bookOmega (su2BookAlgebra 0) := by sorry
