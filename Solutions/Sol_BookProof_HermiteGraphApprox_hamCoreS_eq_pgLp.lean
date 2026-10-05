-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.hamCoreS_eq_pgLp
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_potLp_polyW_eq
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_DegSchrodinger_hamCoreS_pgLp
import Theorems.Thm_BookProof_HermiteLadder_hamPolyL_apply
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
theorem solution {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q) (S : Finset (Fin d))
    (p : MvPolynomial (Fin d) ℂ) :
    hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S ⟨pgLp p, pgLp_mem_core p⟩
      = pgLp (hamPolyL S q p) := by

  rw [hamCoreS_pgLp, hamPolyS, potLp_polyW_eq hq, hamPolyL_apply, pgLp_add']
