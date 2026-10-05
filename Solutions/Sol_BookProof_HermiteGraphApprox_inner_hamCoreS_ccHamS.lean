-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.inner_hamCoreS_ccHamS
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_inner_pgLp_hamPolyL
import Theorems.Thm_BookProof_HermiteGraphApprox_hamCoreS_eq_pgLp
import Theorems.Thm_BookProof_DegSchrodinger_ccHamS_coeFn
import Theorems.Thm_BookProof_DegSchrodinger_contDiff_polyW
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
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
theorem solution {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (S : Finset (Fin d)) (y : polyGaussCore (d := d)) (ψ : ccDomain (Vd d)) :
    (inner ℂ (hamCoreS (polyW q) (continuous_polyW q) (expBounded_polyW q) S y)
        (ψ : L2d d) : ℂ)
      = inner ℂ (y : L2d d) (ccHamS (polyW q) (contDiff_polyW q) S ψ) := by

  obtain ⟨p, hp⟩ := y.2
  have hy : y = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  obtain ⟨f, rfl⟩ := (ccEquiv (Vd d)).surjective ψ
  rw [hy, hamCoreS_eq_pgLp hq]
  exact inner_pgLp_hamPolyL S hq p ((f : 𝓢(Vd d, ℂ)).smooth ⊤) f.2
    ((f : 𝓢(Vd d, ℂ)).coeFn_toLp 2 (volume : Measure (Vd d)))
    (ccHamS_coeFn (polyW q) (contDiff_polyW q) S f)
