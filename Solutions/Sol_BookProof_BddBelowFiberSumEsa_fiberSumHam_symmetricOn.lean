-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.fiberSumHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_symmetricOn
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterBddBelowWallEsa
open BookProof.BddBelowFiberSumEsa




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) :
    SymmetricOn (fiberCore ι) (fiberSumHam V hV) := dsOp_symmetricOn _ (fun i => wallHam_symmetricOn (V i) (hV i))
