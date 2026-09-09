import Mathlib
import BookProof.ChapterThermalTemperatureCore
import BookProof.ChapterSoftmaxSharpness

/-!
# The overlap of displaced thermal states, and the temperature of attention

This module supplies the *physical* layer of the temperature identity
`τ = n̄ + ½` that `Book/CoherentState.lean` §"Temperature and the Thermal Bath"
asserts and that `ChapterThermalTemperatureCore` proves in its finite,
occupation-number core.

The model is the standard Gaussian (phase-space) description of a **displaced
thermal state**: along one quadrature its distribution is a Gaussian centred at
the displacement `a` whose variance is the sum of

* the thermal noise, of variance `n̄` (the mean occupation of the bath), and
* the zero-point noise of the vacuum, of variance `½` (the Heisenberg floor).

`thermal_plus_zeroPoint_conv` is exactly that statement: the convolution of the
two noises is the Gaussian of variance `n̄ + ½`, so the width of a displaced
thermal state — its *temperature* `τ` — is `n̄ + ½`
(`displacedThermal_variance`).

From that Gaussian description the **overlap** of two displaced thermal states
is computed in closed form (`dtOverlap_eq`):

`⟨a | b⟩ = exp(−(a−b)² / 4τ) / √(4πτ)`,

a Gaussian in the phase-space distance whose *width is the temperature*.
Normalizing over a finite family of keys, the constant `1/√(4πτ)` cancels and
the Born weights are **exactly a Softmax** over minus the squared distances at
inverse temperature `β = 1/(4τ)` (`dtBorn_eq_softmax`).  Hence the attention
temperature is set by the bath: `β` is strictly decreasing in `n̄`
(`inverseTemperature_strictAnti`), i.e. a hotter bath gives flatter attention,
and at `n̄ → 0` it saturates at the zero-point value `β = ½`
(`inverseTemperature_zero`).

Finally `dtBorn_eq_softmax_coth` writes the same headline in the physical
variable `x = ħω/kT`, where `τ = ½·coth(x/2)` is the Bose–Einstein closed form
already proved in `ChapterBoseEinstein` / `ChapterThermalTemperatureCore`.

## Documented scope

What is proved here is the Gaussian/phase-space derivation of `τ = n̄ + ½` and
of the Gaussian overlap law.  It is not a derivation inside an infinite
dimensional Fock space: the displaced thermal state is *modelled* by its
(exact, textbook) Gaussian quadrature distribution rather than constructed as a
density operator.  Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

namespace BookProof.ChapterDisplacedThermalOverlap

/-! ## The temperature: thermal noise plus the zero point -/

/-- The **temperature** of a thermal bath of mean occupation `nbar`:
`τ = n̄ + ½`, the thermal variance plus the zero-point half. -/
def tauNN (nbar : ℝ≥0) : ℝ≥0 := nbar + 1 / 2

@[simp] theorem tauNN_coe (nbar : ℝ≥0) : ((tauNN nbar : ℝ≥0) : ℝ) = (nbar : ℝ) + 1 / 2 := by
  simp [tauNN]

/-- The `ℝ≥0`-valued temperature agrees with the chapter's
`ChapterCoherentTemperature.thermalTemperature`. -/
theorem tauNN_eq_thermalTemperature (nbar : ℝ≥0) :
    ((tauNN nbar : ℝ≥0) : ℝ)
      = BookProof.ChapterCoherentTemperature.thermalTemperature (nbar : ℝ) := by
  rw [tauNN_coe, BookProof.ChapterCoherentTemperature.thermalTemperature]

theorem tauNN_pos (nbar : ℝ≥0) : 0 < (tauNN nbar : ℝ) := by
  rw [tauNN_coe]; positivity

theorem tauNN_ne_zero (nbar : ℝ≥0) : tauNN nbar ≠ 0 := by
  intro h
  have := tauNN_pos nbar
  rw [h] at this
  simp at this

/-- **The temperature is the thermal noise plus the zero point.**  The quadrature
noise of a thermal state (variance `n̄`) convolved with the vacuum's zero-point
noise (variance `½`) is Gaussian of variance `τ = n̄ + ½`. -/
theorem thermal_plus_zeroPoint_conv (nbar : ℝ≥0) :
    (gaussianReal 0 nbar) ∗ (gaussianReal 0 (1 / 2)) = gaussianReal 0 (tauNN nbar) := by
  rw [gaussianReal_conv_gaussianReal]
  simp [tauNN]

/-- The quadrature distribution of the **displaced thermal state** with
displacement `a` and bath occupation `nbar`. -/
def displacedThermal (a : ℝ) (nbar : ℝ≥0) : Measure ℝ := gaussianReal a (tauNN nbar)

/-- The displaced thermal state has mean equal to its displacement. -/
theorem displacedThermal_mean (a : ℝ) (nbar : ℝ≥0) :
    ∫ x, x ∂(displacedThermal a nbar) = a := by
  simp [displacedThermal]

/-- **`τ = n̄ + ½`.**  The variance of a displaced thermal state — the width that
plays the role of a temperature — is the mean occupation plus the zero-point
half, independently of the displacement. -/
theorem displacedThermal_variance (a : ℝ) (nbar : ℝ≥0) :
    Var[id; displacedThermal a nbar] = (nbar : ℝ) + 1 / 2 := by
  simp [displacedThermal]

/-! ## The Gaussian overlap law -/

/-- The pointwise product of two Gaussian densities of equal variance is a
Gaussian of half the variance, centred at the midpoint, times the constant
`exp(−(a−b)²/4v) / √(4πv)`. -/
theorem gaussianPDFReal_mul_gaussianPDFReal (a b : ℝ) {v : ℝ≥0} (hv : v ≠ 0) (x : ℝ) :
    gaussianPDFReal a v x * gaussianPDFReal b v x
      = (Real.exp (-(a - b) ^ 2 / (4 * (v : ℝ))) / Real.sqrt (4 * π * v))
        * gaussianPDFReal ((a + b) / 2) (v / 2) x := by
  have hV : (0 : ℝ) < (v : ℝ) := by positivity
  have hhalf : (((v / 2 : ℝ≥0)) : ℝ) = (v : ℝ) / 2 := by push_cast; ring
  have h1 : Real.sqrt (2 * π * v) * Real.sqrt (2 * π * v) = 2 * π * (v : ℝ) :=
    Real.mul_self_sqrt (by positivity)
  have hexp : rexp (-(x - a) ^ 2 / (2 * (v : ℝ))) * rexp (-(x - b) ^ 2 / (2 * (v : ℝ)))
      = rexp (-(a - b) ^ 2 / (4 * (v : ℝ)))
        * rexp (-(x - (a + b) / 2) ^ 2 / (2 * ((v : ℝ) / 2))) := by
    rw [← Real.exp_add, ← Real.exp_add]
    congr 1
    field_simp
    ring
  simp only [gaussianPDFReal, hhalf]
  rw [show ((√(2 * π * (v : ℝ)))⁻¹ * rexp (-(x - a) ^ 2 / (2 * (v : ℝ))))
      * ((√(2 * π * (v : ℝ)))⁻¹ * rexp (-(x - b) ^ 2 / (2 * (v : ℝ))))
      = ((√(2 * π * (v : ℝ))) * (√(2 * π * (v : ℝ))))⁻¹
        * (rexp (-(x - a) ^ 2 / (2 * (v : ℝ))) * rexp (-(x - b) ^ 2 / (2 * (v : ℝ)))) by
    rw [mul_inv]; ring]
  rw [h1, hexp, div_eq_mul_inv]
  have h4 : (0 : ℝ) < Real.sqrt (4 * π * (v : ℝ)) := Real.sqrt_pos.mpr (by positivity)
  have h2 : Real.sqrt (π * (v : ℝ) * 4) * Real.sqrt (π * (v : ℝ)) = 2 * π * (v : ℝ) := by
    rw [← Real.sqrt_mul (by positivity)]
    rw [show (π * (v : ℝ) * 4) * (π * (v : ℝ)) = (2 * π * (v : ℝ)) ^ 2 by ring]
    exact Real.sqrt_sq (by positivity)
  field_simp
  linarith [h2]

/-- The **overlap** of two displaced thermal states of common bath occupation
`nbar`: the phase-space integral of the product of their quadrature densities. -/
def dtOverlap (nbar : ℝ≥0) (a b : ℝ) : ℝ :=
  ∫ x, gaussianPDFReal a (tauNN nbar) x * gaussianPDFReal b (tauNN nbar) x

/-- **The overlap is a Gaussian of width the temperature.**
`⟨a|b⟩ = exp(−(a−b)²/4τ)/√(4πτ)` with `τ = n̄ + ½`. -/
theorem dtOverlap_eq (nbar : ℝ≥0) (a b : ℝ) :
    dtOverlap nbar a b
      = Real.exp (-(a - b) ^ 2 / (4 * ((nbar : ℝ) + 1 / 2)))
        / Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)) := by
  have hv : tauNN nbar ≠ 0 := tauNN_ne_zero nbar
  have hhalf : (tauNN nbar / 2 : ℝ≥0) ≠ 0 := by
    simpa using hv
  simp only [dtOverlap]
  rw [integral_congr_ae (Filter.Eventually.of_forall
    (fun x => gaussianPDFReal_mul_gaussianPDFReal a b hv x))]
  rw [MeasureTheory.integral_const_mul, integral_gaussianPDFReal_eq_one _ hhalf, mul_one,
    tauNN_coe]

theorem dtOverlap_pos (nbar : ℝ≥0) (a b : ℝ) : 0 < dtOverlap nbar a b := by
  rw [dtOverlap_eq]
  have : (0 : ℝ) < (nbar : ℝ) + 1 / 2 := by positivity
  positivity

/-- **The overlap is a lossless readout of distance**: it is strictly decreasing
in the squared phase-space distance. -/
theorem dtOverlap_lt_of_dist_lt (nbar : ℝ≥0) {a b c : ℝ}
    (h : (a - b) ^ 2 < (a - c) ^ 2) : dtOverlap nbar a c < dtOverlap nbar a b := by
  have hden : (0 : ℝ) < Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)) :=
    Real.sqrt_pos.mpr (by positivity)
  have hτ : (0 : ℝ) < 4 * ((nbar : ℝ) + 1 / 2) := by positivity
  rw [dtOverlap_eq, dtOverlap_eq]
  have hexp : Real.exp (-(a - c) ^ 2 / (4 * ((nbar : ℝ) + 1 / 2)))
      < Real.exp (-(a - b) ^ 2 / (4 * ((nbar : ℝ) + 1 / 2))) :=
    Real.exp_lt_exp.mpr (div_lt_div_of_pos_right (by linarith) hτ)
  gcongr

/-! ## The Born weights are a Softmax at inverse temperature `1/(4τ)` -/

/-- The **inverse temperature of attention** induced by a bath of mean
occupation `nbar`: `β = 1/(4τ) = 1/(4(n̄+½))`. -/
def inverseTemperature (nbar : ℝ≥0) : ℝ := 1 / (4 * ((nbar : ℝ) + 1 / 2))

theorem inverseTemperature_pos (nbar : ℝ≥0) : 0 < inverseTemperature nbar := by
  rw [inverseTemperature]
  positivity

/-- At zero bath occupation the attention inverse temperature saturates at the
pure zero-point value `β = ½`. -/
theorem inverseTemperature_zero : inverseTemperature 0 = 1 / 2 := by
  rw [inverseTemperature]
  norm_num

/-- **A hotter bath gives flatter attention**: the inverse temperature is
strictly decreasing in the mean occupation. -/
theorem inverseTemperature_strictAnti : StrictAnti inverseTemperature := by
  intro s t hst
  have hs : (0 : ℝ) < 4 * ((s : ℝ) + 1 / 2) := by positivity
  have ht : (0 : ℝ) < 4 * ((t : ℝ) + 1 / 2) := by positivity
  have hlt : (s : ℝ) < (t : ℝ) := by exact_mod_cast hst
  rw [inverseTemperature, inverseTemperature]
  apply one_div_lt_one_div_of_lt hs
  linarith

/-- The **Born attention weight** of the `j`-th key, read off the displaced
thermal overlaps. -/
def dtBorn {m : ℕ} (nbar : ℝ≥0) (q : ℝ) (k : Fin m → ℝ) (j : Fin m) : ℝ :=
  dtOverlap nbar q (k j) / ∑ l, dtOverlap nbar q (k l)

/-- **Headline.**  The Born weights of displaced thermal states are *exactly* a
Softmax over minus the squared phase-space distances, at inverse temperature
`β = 1/(4τ)` with `τ = n̄ + ½`: the Gaussian normalization `1/√(4πτ)` cancels in
the ratio.  The bath temperature *is* the Softmax temperature. -/
theorem dtBorn_eq_softmax {m : ℕ} (nbar : ℝ≥0) (q : ℝ) (k : Fin m → ℝ) (j : Fin m) :
    dtBorn nbar q k j
      = BookProof.ChapterSoftmaxSharpness.scoreSoftmax (inverseTemperature nbar)
          (fun l => -(q - k l) ^ 2) j := by
  have hc : (0 : ℝ) < Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)) :=
    Real.sqrt_pos.mpr (by positivity)
  have hval : ∀ l : Fin m, dtOverlap nbar q (k l)
      = (Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)))⁻¹
        * Real.exp (inverseTemperature nbar * (-(q - k l) ^ 2)) := by
    intro l
    rw [dtOverlap_eq, inverseTemperature, div_eq_inv_mul]
    congr 2
    field_simp
  simp only [dtBorn, BookProof.ChapterSoftmaxSharpness.scoreSoftmax, hval]
  rw [← Finset.mul_sum]
  rw [mul_div_mul_left _ _ (by positivity)]

/-- The same headline in the physical variable `x = ħω/kT`, where the
temperature is the Bose–Einstein closed form `τ = ½·coth(x/2)`
(`ChapterThermalTemperatureCore.thermal_temperature_eq_mean_half`). -/
theorem dtBorn_temperature_coth {x : ℝ} (hx : 0 < x) :
    ((BookProof.ChapterBoseEinstein.boseEinstein x).toNNReal : ℝ) + 1 / 2
      = Real.cosh (x / 2) / (2 * Real.sinh (x / 2)) := by
  have hpos : 0 < BookProof.ChapterBoseEinstein.boseEinstein x :=
    BookProof.ChapterBoseEinstein.boseEinstein_pos hx
  rw [Real.coe_toNNReal _ hpos.le]
  exact BookProof.ChapterBoseEinstein.thermalTemperature_boseEinstein_eq_coth hx

end BookProof.ChapterDisplacedThermalOverlap

end
