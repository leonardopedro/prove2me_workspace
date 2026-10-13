-- Generated from ChapterYangMillsAbelianFockEsa.lean — solution of BookProof.YmAbelianFock.ymAbelianFock_positiveExtension_eq_closure
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Theorems.Thm_BookProof_YmAbelianFock_dGamma_ymAbelian_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_YmAbelianFock_dGammaOp_ymAbelianHermCol_symmetricOn
import Theorems.Thm_BookProof_EsaClosure_positiveExtension_eq_closure_of_esa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterQymTimeIndependentFlow
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YmAbelianFock




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QymTimeIndependent BookProof.QgTimeIndependent
open BookProof.EsaClosure
open BookProof.FockSecondQuantization

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ))
    {Dom : Submodule ℂ Fock} {A : Dom →ₗ[ℂ] Fock}
    (hA : IsPositiveSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) A) :
    Dom = clDom (dGammaOp (ymAbelianHermCol e)) ∧
      ∀ (x : Fock) (h : x ∈ Dom) (h' : x ∈ clDom (dGammaOp (ymAbelianHermCol e))),
        A ⟨x, h⟩ = clExt (dGammaOp (ymAbelianHermCol e)) finiteOccupation_dense
          (dGammaOp_ymAbelianHermCol_symmetricOn e) ⟨x, h'⟩ :=
  positiveExtension_eq_closure_of_esa finiteOccupation_dense
      (dGammaOp_ymAbelianHermCol_symmetricOn e)
      (dGamma_ymAbelian_essentiallySelfAdjointOn_core e) hA
