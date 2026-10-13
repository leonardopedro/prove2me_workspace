-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.eq_zero_of_orth_dense
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
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
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ (L2d d)} (hD : Dense (D : Set (L2d d)))
    {y : L2d d} (h : ∀ x ∈ D, (inner ℂ x y : ℂ) = 0) : y = 0 := by

  have hc : IsClosed {x : L2d d | (inner ℂ x y : ℂ) = 0} :=
    isClosed_eq (continuous_id.inner continuous_const) continuous_const
  have hall : Set.univ ⊆ {x : L2d d | (inner ℂ x y : ℂ) = 0} := by
    rw [← hD.closure_eq]
    exact hc.closure_subset_iff.2 fun x hx => h x hx
  exact inner_self_eq_zero.1 (hall (Set.mem_univ y))
