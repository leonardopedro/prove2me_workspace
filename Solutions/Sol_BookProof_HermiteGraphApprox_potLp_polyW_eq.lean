-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.potLp_polyW_eq
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_DegSchrodinger_pgFun_mul_polyW
import Theorems.Thm_BookProof_QgHermiteFriedrichs_potLp_coeFn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterYangMillsHermite
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
open BookProof.QgHermiteFriedrichs
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (p : MvPolynomial (Fin d) ℂ) :
    potLp (polyW q) (continuous_polyW q) (expBounded_polyW q) p = pgLp (q * p) := by

  refine MeasureTheory.Lp.ext ?_
  filter_upwards [potLp_coeFn (polyW q) (continuous_polyW q) (expBounded_polyW q) p,
    pgLp_coeFn (q * p)] with x h1 h2
  rw [h1, h2, pgFun_mul_polyW hq]
