-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFock_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFockCore_dense
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFockHam_symmetricOn
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFockHam_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (Dom : Submodule ℂ ymFockSpace) (A : Dom →ₗ[ℂ] ymFockSpace),
      IsPositiveSelfAdjointExtension (ymFockHam fabc) A :=
  friedrichs_extension_exists
      ⟨ymFockCore, ymFockHam fabc, ymFockHam_symmetricOn fabc, ymFockHam_quadForm_nonneg fabc⟩
      ymFockCore_dense
