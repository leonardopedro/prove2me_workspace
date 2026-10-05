-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.tendsto_toLp_of_le
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {f : ℕ → Vd d → ℂ} {g : Vd d → ℂ}
    (hf : ∀ n, MemLp (f n) 2 (volume : Measure (Vd d))) (hg : MemLp g 2 (volume : Measure (Vd d)))
    {e : ℕ → ENNReal} (he : Tendsto e atTop (𝓝 0)) (B : ℝ)
    (hle : ∀ n, eLpNorm (f n - g) 2 (volume : Measure (Vd d)) ≤ ENNReal.ofReal B * e n) :
    Tendsto (fun n => (hf n).toLp (f n)) atTop (𝓝 (hg.toLp g)) := by

  rw [Lp.tendsto_Lp_iff_tendsto_eLpNorm'']
  have h2 : Tendsto (fun n => ENNReal.ofReal B * e n) atTop (𝓝 0) := by
    simpa using ENNReal.Tendsto.const_mul he (Or.inr ENNReal.ofReal_ne_top)
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le tendsto_const_nhds h2 (fun _ => zero_le) hle
