-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.abs_nParticleW_le
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_sum_harmW_partLM
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {V : Vd d → ℝ} {a b : ℝ}
    (hV : ∀ y, |V y| ≤ a * harmW y + b) (n : ℕ) (x : Vd (n * d)) :
    |nParticleW V n x| ≤ a * harmW x + n * b := by

  have hstep : |∑ k : Fin n, V (partLM n d k x)| ≤ ∑ k : Fin n, |V (partLM n d k x)| :=
    Finset.abs_sum_le_sum_abs _ _
  have hbound : ∑ k : Fin n, |V (partLM n d k x)|
      ≤ ∑ k : Fin n, (a * harmW (partLM n d k x) + b) :=
    Finset.sum_le_sum fun k _ => hV _
  have hsum : ∑ k : Fin n, (a * harmW (partLM n d k x) + b)
      = a * harmW x + n * b := by
    rw [Finset.sum_add_distrib, ← Finset.mul_sum, sum_harmW_partLM]
    simp [mul_comm]
  rw [nParticleW]
  linarith [hstep, hbound, hsum.le, hsum.ge]
