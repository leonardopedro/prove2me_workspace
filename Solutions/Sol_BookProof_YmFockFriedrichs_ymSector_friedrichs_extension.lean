-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymSector_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ymSectorHam_symmetricOn
import Theorems.Thm_BookProof_YmFockFriedrichs_ymSectorHam_quadForm_nonneg
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
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ) :
    ∃ (Dom : Submodule ℂ (L2d (n * 99))) (A : Dom →ₗ[ℂ] L2d (n * 99)),
      IsPositiveSelfAdjointExtension (ymSectorHam fabc n) A :=
  friedrichs_extension_exists
      ⟨polyGaussCore, ymSectorHam fabc n, ymSectorHam_symmetricOn fabc n,
        ymSectorHam_quadForm_nonneg fabc n⟩
      polyGaussCore_dense
