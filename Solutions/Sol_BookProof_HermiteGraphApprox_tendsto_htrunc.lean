-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.tendsto_htrunc
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteLadder_coef_eq_repr
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvBasis_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : L2d d) : Tendsto (htrunc v) atTop (𝓝 v) := by

  have h := hermiteMvBasis.hasSum_repr v
  have heq : htrunc v = fun F => ∑ a ∈ F, hermiteMvBasis.repr v a • hermiteMvBasis a := by
    funext F
    simp [htrunc, coef_eq_repr]
  rw [heq]
  exact h
