-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.harmCore_hermiteMvLp
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_kinPoly_add_harmPoly_hermiteMv
import Theorems.Thm_BookProof_QgHermiteOscillator_harmCore_pgLp
open BookProof.QgHermiteOscillator












open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  {ι : Type*} {D : Submodule ℂ F}





variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) :
    harmCore ⟨hermiteMvLp a, hermiteMvLp_mem_core a⟩
      = (((mvDeg a : ℝ) + (d : ℝ) / 2 : ℝ) : ℂ) • (hermiteMvLp a : L2d d) := by

  have hsm : (hermiteMvLp (d := d) a) = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a) := rfl
  have hmem : (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a)) ∈ polyGaussCore (d := d) := by
    rw [← hsm]
    exact hermiteMvLp_mem_core a
  have hstep : harmCore ⟨((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a), hmem⟩
      = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • harmCore ⟨pgLp (hermiteMv a), pgLp_mem_core _⟩ := by
    rw [← map_smul]
    congr 1
  have hcast : ((((mvDeg a : ℝ) + (d : ℝ) / 2 : ℝ)) : ℂ) = ((mvDeg a : ℂ) + (d : ℂ) / 2) := by
    push_cast
    ring
  simp only [hsm]
  rw [hstep, harmCore_pgLp, kinPoly_add_harmPoly_hermiteMv,
    ← HermiteProductCore.pgMap_apply, map_smul, HermiteProductCore.pgMap_apply, hcast,
    smul_comm]
