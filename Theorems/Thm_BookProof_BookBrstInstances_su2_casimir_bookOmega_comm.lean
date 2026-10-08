-- Generated from ChapterBookBrstInstances.lean — theorem BookProof.BookBrstInstances.su2_casimir_bookOmega_comm
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.ChapterLinftyMultiplication
open BookProof.SmBrstGhost
open BookProof.YangMillsGhost
open BookProof.BookBrstInstances



open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)


theorem BookProof.BookBrstInstances.su2_casimir_bookOmega_comm :
    bookOmega (su2BookAlgebra 0) * multOp (casimirPoly (N := 3))
      = multOp (casimirPoly (N := 3)) * bookOmega (su2BookAlgebra 0) := by sorry
