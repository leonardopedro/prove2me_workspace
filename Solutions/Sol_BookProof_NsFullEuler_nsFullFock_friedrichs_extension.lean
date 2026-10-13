-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullFock_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_nsFockCore_dense
import Theorems.Thm_BookProof_NsFullEuler_nsFullFockHam_symmetricOn
import Theorems.Thm_BookProof_NsFullEuler_nsFullFockHam_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) :
    ∃ (Dom : Submodule ℂ nsFockSpace) (A : Dom →ₗ[ℂ] nsFockSpace),
      IsPositiveSelfAdjointExtension (nsFullFockHam nu lam mu gg) A :=
  friedrichs_extension_exists
      ⟨nsFockCore, nsFullFockHam nu lam mu gg, nsFullFockHam_symmetricOn nu lam mu gg,
        nsFullFockHam_quadForm_nonneg nu lam mu gg⟩
      nsFockCore_dense
