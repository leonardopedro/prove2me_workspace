-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.hamCoreS_esa
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_exists_core_graph_approx
import Theorems.Thm_BookProof_DegKatoEsa_ccHamS_esa
import Theorems.Thm_BookProof_DegSchrodinger_contDiff_polyW
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_QgOneParticleCc_essentiallySelfAdjointOn_of_graphApprox
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : MvPolynomial (Fin d) ℂ) (hq : RealCoeff q)
    (hq1 : ∀ x, 1 ≤ polyW q x) (S : Finset (Fin d)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S) :=
  essentiallySelfAdjointOn_of_graphApprox _ _
      (fun ψ _ hε => exists_core_graph_approx q hq S ψ hε)
      (ccHamS_esa (polyW q) (contDiff_polyW q) hq1 S)
