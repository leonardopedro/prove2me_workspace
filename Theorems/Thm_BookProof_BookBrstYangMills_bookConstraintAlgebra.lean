-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.bookConstraintAlgebra
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterA4
open BookProof.YangMillsGhost

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.bookConstraintAlgebra : ConstraintAlgebra G.f (gaussGen G) chiOp betaOp where
  comm_chi _ _ := by sorry
