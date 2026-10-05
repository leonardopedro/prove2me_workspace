-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.rsmul_eq_csmul
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.YangMillsGhost
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.rsmul_eq_csmul (r : ℝ) (T : Module.End ℂ (BookState N)) :
    r • T = ((r : ℝ) : ℂ) • T := by sorry
