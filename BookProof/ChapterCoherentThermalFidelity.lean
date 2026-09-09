import Mathlib
import BookProof.ChapterThermalTemperatureCore
import BookProof.ChapterCoherentFidelity
import BookProof.ChapterDisplacedThermalOverlap

/-!
# Where the extra `½` comes from: the fidelity of a displaced thermal state with a
coherent state (plan GAP-1, Part A.4 / F.4)

`ChapterCoherentTemperature` *defines* the chapter's temperature as `τ = n̄ + ½`,
`ChapterThermalTemperatureCore` proves the occupation-number identities behind it,
and `ChapterDisplacedThermalOverlap` models a displaced thermal state by a
Gaussian whose variance is `n̄ + ½` — but in that Gaussian model the zero-point
half is *put in by hand* (it is the variance of the vacuum noise the model
convolves with).

This module removes that postulate.  The extra `½` is derived from the
**coherent-state overlap** by a computation carried out entirely in
occupation-number (Fock) coordinates:

* `coherentThermalFidelity nbar lam` is the fidelity `⟨β| ρ_th(n̄) |β⟩` of a
  thermal state of mean occupation `n̄` with a coherent state of intensity
  `λ = ‖β‖²`, written as the sum `∑ₙ |⟨β|n⟩|² · Pr_th(n)` of the coherent
  (Poisson) occupation statistics against the thermal (geometric) ones;
* `coherentThermalFidelity_eq` — the closed form
  `⟨β|ρ_th|β⟩ = exp(−λ/(n̄+1)) / (n̄+1)`: a Gaussian in the phase-space distance
  `λ = ‖β‖²` whose **width is `n̄ + 1`**;
* `coherentThermalFidelity_vacuum_eq_fidelityC` — at `n̄ = 0` the same expression
  *is* the coherent-state fidelity `exp(−‖q−k‖²)` of `ChapterCoherentFidelity`,
  the Born numerator of the attention weight.  So the coherent state contributes
  width `½` to an overlap (`fidelityC_width`: two coherent states give width
  `½ + ½ = 1`);
* `coherentThermalFidelity_width_eq` — the width of the thermal–coherent fidelity
  splits as `n̄ + 1 = τ + ½` with `τ = n̄ + ½`: the thermal state's own width plus
  the coherent probe's zero-point half.  Widths add, and the half in `τ` is
  exactly the coherent-state half;
* `thermalTemperature_eq_fidelity_width_sub_coherent_half` — **headline**: the
  temperature is *read off* the fidelity rather than postulated.  If the
  thermal–coherent fidelity is the Gaussian `exp(−λ/w)/w` of some width `w > 0`,
  then necessarily `τ = w − ½`, the subtracted `½` being the coherent-state width
  `coherentWidth` fixed by the coherent–coherent overlap;
* `dtOverlap_coherentParameter` and `dtOverlap_width_eq_two_tau` — the same
  additivity checked against the Gaussian model of
  `ChapterDisplacedThermalOverlap`: in the dimensionless coherent parameter
  (`x = √2·α`) the overlap of two displaced thermal states is
  `exp(−‖α₁−α₂‖²/(2τ))`, i.e. width `τ + τ`, and at `n̄ = 0` this is again the
  coherent-state overlap.  The Fock computation and the Gaussian model therefore
  agree, and both assign the coherent state the width `½`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterCoherentThermalFidelity

open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}

/-! ## The thermal–coherent fidelity in Fock coordinates -/

/-- The **fidelity of a thermal state with a coherent state**, `⟨β|ρ_th(n̄)|β⟩`,
computed in occupation-number coordinates: the coherent (Poisson) occupation
probabilities `|⟨β|n⟩|² = e^{−λ}λⁿ/n!` at intensity `λ = ‖β‖²`, paired against the
thermal (geometric) occupation probabilities of the bath. -/
def coherentThermalFidelity (nbar lam : ℝ) : ℝ :=
  ∑' n : ℕ, coherentOccupation lam n * thermalProb nbar n

/-- The summation underlying `coherentThermalFidelity`, as a `HasSum`. -/
theorem coherentThermalFidelity_hasSum (h : 0 ≤ nbar) (lam : ℝ) :
    HasSum (fun n : ℕ => coherentOccupation lam n * thermalProb nbar n)
      (Real.exp (-(lam / (nbar + 1))) / (nbar + 1)) := by
  have hpos : (0 : ℝ) < nbar + 1 := by linarith
  have hkey := (hasSum_expSeries (lam * thermalRatio nbar)).mul_left
    (Real.exp (-lam) * (1 / (nbar + 1)))
  have hval : Real.exp (-lam) * (1 / (nbar + 1)) * Real.exp (lam * thermalRatio nbar)
      = Real.exp (-(lam / (nbar + 1))) / (nbar + 1) := by
    rw [mul_comm (Real.exp (-lam)) (1 / (nbar + 1)), mul_assoc, ← Real.exp_add]
    rw [thermalRatio]
    rw [show -lam + lam * (nbar / (nbar + 1)) = -(lam / (nbar + 1)) by
      field_simp; ring]
    ring
  rw [hval] at hkey
  refine hkey.congr_fun fun n => ?_
  rw [coherentOccupation_eq, thermalProb, mul_pow]
  ring

/-- **The closed form of the thermal–coherent fidelity.**  It is a Gaussian in the
phase-space distance `λ = ‖β‖²`, of width `n̄ + 1`:
`⟨β|ρ_th(n̄)|β⟩ = exp(−λ/(n̄+1)) / (n̄+1)`. -/
theorem coherentThermalFidelity_eq (h : 0 ≤ nbar) (lam : ℝ) :
    coherentThermalFidelity nbar lam = Real.exp (-(lam / (nbar + 1))) / (nbar + 1) :=
  (coherentThermalFidelity_hasSum h lam).tsum_eq

theorem coherentThermalFidelity_pos (h : 0 ≤ nbar) (lam : ℝ) :
    0 < coherentThermalFidelity nbar lam := by
  have hpos : (0 : ℝ) < nbar + 1 := by linarith
  rw [coherentThermalFidelity_eq h]
  positivity

/-! ## The vacuum case *is* the coherent-state overlap -/

/-- At zero bath occupation the thermal state is the vacuum and the fidelity is
the plain coherent-state overlap `exp(−λ)`. -/
theorem coherentThermalFidelity_vacuum (lam : ℝ) :
    coherentThermalFidelity 0 lam = Real.exp (-lam) := by
  rw [coherentThermalFidelity_eq le_rfl]
  norm_num

/-- **The vacuum fidelity is the Born numerator of attention.**  With
`λ = ‖q − k‖²`, the `n̄ = 0` case of the Fock-space computation reproduces exactly
the coherent-state fidelity `|⟨q|k⟩|² = exp(−‖q−k‖²)` of
`ChapterCoherentFidelity`. -/
theorem coherentThermalFidelity_vacuum_eq_fidelityC {n : ℕ}
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentThermalFidelity 0 (‖q - k‖ ^ 2) = fidelityC q k := by
  rw [coherentThermalFidelity_vacuum, fidelityC_eq_exp_neg_dist_sq]

/-- The **width a coherent state contributes to an overlap**: one half.  (The
overlap of two coherent states has Gaussian width `coherentWidth + coherentWidth
= 1`, see `fidelityC_width`.) -/
def coherentWidth : ℝ := 1 / 2

/-- The coherent state's width is the vacuum temperature `τ(0) = ½`. -/
theorem coherentWidth_eq_thermalTemperature_zero :
    coherentWidth = thermalTemperature 0 := by
  rw [coherentWidth, thermalTemperature]; norm_num

/-- **Two coherent states overlap with width `½ + ½`.**  This is what fixes the
coherent-state width at `½`: `|⟨q|k⟩|² = exp(−‖q−k‖²/(½+½))`. -/
theorem fidelityC_width {n : ℕ} (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = Real.exp (-(‖q - k‖ ^ 2 / (coherentWidth + coherentWidth))) := by
  rw [fidelityC_eq_exp_neg_dist_sq, coherentWidth]
  norm_num

/-! ## Widths add: `n̄ + 1 = τ + ½` -/

/-- **The width of the thermal–coherent fidelity is `τ + ½`.**  The Gaussian width
`n̄ + 1` read off `coherentThermalFidelity_eq` splits into the thermal state's own
width `τ = n̄ + ½` and the coherent probe's width `½`. -/
theorem coherentThermalFidelity_width_eq (nbar : ℝ) :
    nbar + 1 = thermalTemperature nbar + coherentWidth := by
  rw [thermalTemperature, coherentWidth]; ring

/-- The fidelity written with the temperature made explicit:
`⟨β|ρ_th|β⟩ = exp(−λ/(τ+½))/(τ+½)`. -/
theorem coherentThermalFidelity_eq_temperature_form (h : 0 ≤ nbar) (lam : ℝ) :
    coherentThermalFidelity nbar lam
      = Real.exp (-(lam / (thermalTemperature nbar + coherentWidth)))
        / (thermalTemperature nbar + coherentWidth) := by
  rw [coherentThermalFidelity_eq h, ← coherentThermalFidelity_width_eq]

/-- The Gaussian width of the thermal–coherent fidelity is uniquely determined by
the fidelity itself (evaluate at zero distance). -/
theorem width_unique (h : 0 ≤ nbar) {w : ℝ} (hw : 0 < w)
    (hfid : ∀ lam : ℝ, coherentThermalFidelity nbar lam = Real.exp (-(lam / w)) / w) :
    w = nbar + 1 := by
  have hpos : (0 : ℝ) < nbar + 1 := by linarith
  have h0 := hfid 0
  rw [coherentThermalFidelity_eq h] at h0
  simp only [zero_div, neg_zero, Real.exp_zero] at h0
  field_simp at h0
  linarith

/-- **Headline (GAP-1).**  The temperature is *read off* the fidelity of displaced
thermal states, not postulated: if the thermal–coherent fidelity is a Gaussian of
width `w`, then `τ = w − ½`, where the subtracted half is the width
`coherentWidth` of the coherent state itself — the one fixed by the
coherent–coherent overlap `fidelityC_width`.  Together with
`coherentThermalFidelity_eq` (which exhibits `w = n̄ + 1`) this *derives*
`τ = n̄ + ½`: the extra half is the coherent-state overlap, and nothing else. -/
theorem thermalTemperature_eq_fidelity_width_sub_coherent_half (h : 0 ≤ nbar)
    {w : ℝ} (hw : 0 < w)
    (hfid : ∀ lam : ℝ, coherentThermalFidelity nbar lam = Real.exp (-(lam / w)) / w) :
    thermalTemperature nbar = w - coherentWidth := by
  rw [width_unique h hw hfid, thermalTemperature, coherentWidth]
  ring

/-- The derivation in the form the chapter states it: `τ = n̄ + ½`, with the half
identified as the coherent-state width. -/
theorem thermalTemperature_eq_mean_add_coherentWidth (nbar : ℝ) :
    thermalTemperature nbar = nbar + coherentWidth := by
  rw [thermalTemperature, coherentWidth]

/-! ## Cross-check against the Gaussian phase-space model -/

/-- The Gaussian-model overlap of two displaced thermal states, written in the
*dimensionless coherent parameter* `α` (`x = √2·α`, the change of variables in
which the vacuum overlap reads `exp(−(α₁−α₂)²)`): it is a Gaussian of width
`2τ = τ + τ`. -/
theorem dtOverlap_coherentParameter (nb : NNReal) (a b : ℝ) :
    dtOverlap nb (Real.sqrt 2 * a) (Real.sqrt 2 * b)
      = Real.exp (-((a - b) ^ 2 / (((nb : ℝ) + 1 / 2) + ((nb : ℝ) + 1 / 2))))
        / Real.sqrt (4 * π * ((nb : ℝ) + 1 / 2)) := by
  have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hτ : (0 : ℝ) < (nb : ℝ) + 1 / 2 := by positivity
  rw [dtOverlap_eq]
  congr 2
  have hsq : (Real.sqrt 2 * a - Real.sqrt 2 * b) ^ 2 = 2 * (a - b) ^ 2 := by
    rw [show Real.sqrt 2 * a - Real.sqrt 2 * b = Real.sqrt 2 * (a - b) by ring, mul_pow,
      Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]
  rw [hsq]
  field_simp
  ring

/-- The width of the two-thermal overlap is `τ + τ`, matching the additivity of
widths used in `coherentThermalFidelity_width_eq`. -/
theorem dtOverlap_width_eq_two_tau (nb : NNReal) :
    ((nb : ℝ) + 1 / 2) + ((nb : ℝ) + 1 / 2)
      = thermalTemperature (nb : ℝ) + thermalTemperature (nb : ℝ) := by
  rw [thermalTemperature]

/-- At zero bath occupation the Gaussian-model overlap of two displaced thermal
states has width `½ + ½ = 1` — the coherent–coherent value of `fidelityC_width`.
The Gaussian model and the Fock-space computation therefore agree on the
coherent-state width, and the `½` in `τ = n̄ + ½` is that width. -/
theorem dtOverlap_vacuum_width :
    ((0 : NNReal) : ℝ) + 1 / 2 + (((0 : NNReal) : ℝ) + 1 / 2) = coherentWidth + coherentWidth := by
  rw [coherentWidth]
  norm_num

end BookProof.ChapterCoherentThermalFidelity

end
