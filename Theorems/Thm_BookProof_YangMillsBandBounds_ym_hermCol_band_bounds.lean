-- Generated from ChapterYangMillsBandBounds.lean — theorem BookProof.YangMillsBandBounds.ym_hermCol_band_bounds
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Definitions.Def_ChapterQuadraticFockEsa
open BookProof.QuadFockEsa
open BookProof.YangMillsBandBounds



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

theorem BookProof.YangMillsBandBounds.ym_hermCol_band_bounds (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (ymHermCol e fabc k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (ymHermCol e fabc k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ 4) ∧
      (∀ k j, ‖ymHermCol e fabc k j‖ ≤ C * (((e k).degree : ℝ) + 1) ^ 2) := by sorry
