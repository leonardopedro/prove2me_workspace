-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.exists_hamCoreS_bound
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_hamCoreS_eq_pgLp
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_norm_sq_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
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
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (S : Finset (Fin d)) {n : ℕ} (hT : LadderOrd (hamPolyL S q) n) :
    ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ y : polyGaussCore (d := d),
      ENNReal.ofReal (‖hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S y‖ ^ 2)
        ≤ C * hn n (y : L2d d) := by

  obtain ⟨C, hC, h⟩ := hT.norm_sq_le
  refine ⟨C, hC, fun y => ?_⟩
  obtain ⟨p, hp⟩ := y.2
  have hy : y = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  rw [hy, hamCoreS_eq_pgLp hq]
  exact h p
