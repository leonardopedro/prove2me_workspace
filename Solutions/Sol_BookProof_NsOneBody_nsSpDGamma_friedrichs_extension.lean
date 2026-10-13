-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.nsSpDGamma_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_FockSecondQuantization_secondQuantization_friedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsHermite

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (nsSpCol e nu k)) A :=
  secondQuantization_friedrichs (coreBasis e) (nsOnePart e nu k)
      (spHam_symmetricOn (coreRepBasis e) nu k) (spHam_quadForm_nonneg (coreRepBasis e) nu k)
