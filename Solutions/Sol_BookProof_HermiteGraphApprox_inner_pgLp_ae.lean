-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.inner_pgLp_ae
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
theorem solution {h : MvPolynomial (Fin d) ℂ} {v : L2d d} {g : Vd d → ℂ}
    (hv : (v : Vd d → ℂ) =ᵐ[volume] g) :
    (inner ℂ (pgLp h) v : ℂ) = ∫ x, (starRingEnd ℂ) (pgFun h x) * g x := by

  rw [L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [pgLp_coeFn h, hv] with x h1 h2
  rw [h1, h2, RCLike.inner_apply, mul_comm]
