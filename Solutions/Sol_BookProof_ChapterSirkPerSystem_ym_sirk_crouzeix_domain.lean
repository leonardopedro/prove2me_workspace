-- Generated from ChapterSirkPerSystem.lean — solution of BookProof.ChapterSirkPerSystem.ym_sirk_crouzeix_domain
import Mathlib
import Definitions.Def_ChapterSirkPerSystem
import Theorems.Thm_BookProof_ChapterSirkSpectralGeometry_crouzeix_domain_shiftInvert
import Theorems.Thm_BookProof_ChapterSirkSpectralGeometry_numRange_subset_realSegment_of_shiftInvert
import Theorems.Thm_BookProof_YangMillsHermite_ym_hermite_hashimoto_selects
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterSirkSpectralGeometry
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesHashimoto
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
open BookProof.ChapterSirkPerSystem










noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH9 BookProof.ChapterSirkSpectralGeometry
open BookProof.HashimotoShiftInvert BookProof.FarisLavine BookProof.EsaClosure
open BookProof.YangMillsFriedrichs BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.DiffHashimoto BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianKatoRellich

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ (L2d 99)) (A : Dom →ₗ[ℂ] L2d 99) (R : L2d 99 →L[ℂ] L2d 99),
      IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepBasis e) fabc) A ∧
        IsShiftInvert A γ R ∧ IsSelfAdjoint R ∧
        numRange R ⊆ realSegment 0 γ⁻¹ ∧
        ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 99),
          (∀ x, ‖V x‖ = ‖x‖) →
            convexHull ℝ (numRange (compress V R)) ⊆ realSegment 0 γ⁻¹ := by

  obtain ⟨Dom, A, R, hpsa, hR, hsa, _, _⟩ := ym_hermite_hashimoto_selects e fabc hγ
  have hsym := hpsa.2.1
  have hpos := hpsa.2.2.1
  refine ⟨Dom, A, R, hpsa, hR, hsa,
    numRange_subset_realSegment_of_shiftInvert hR hsym hpos hγ, ?_⟩
  intro m V hViso
  exact crouzeix_domain_shiftInvert hR hsym hpos hγ V hViso
