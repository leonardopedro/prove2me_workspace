import Mathlib

/-!
# Chapter "The Coherent State of Attention", §"Temperature and the Thermal Bath" —
the provable finite core

The chapter claims the temperature identity `τ = n̄ + 1/2` for a displaced thermal
state with mean occupation `n̄`, the `1/2` being the zero-point energy of the
vacuum.

**Status of the full claim: documented gap, not a theorem.**  Deriving
`τ = n̄ + 1/2` requires the quantum fidelity of two *displaced thermal states* on
an infinite-dimensional bosonic Fock space, which is well outside Mathlib
v4.28.0.  Nothing here is `sorry`-ed: instead this module proves the *statistical
core* the identity rests on — the moment structure of the thermal (Bose–Einstein
/ geometric) occupation distribution — and records the remaining step honestly.

What is proved:

* `thermalProb` — the thermal occupation distribution
  `Pr(n) = (1/(n̄+1)) · (n̄/(n̄+1))ⁿ`, i.e. `Pr(n) ∝ (n̄/(n̄+1))ⁿ`;
* `thermalProb_nonneg`, `thermalProb_tsum_one` — it is a probability distribution
  on `ℕ`;
* `thermalProb_mean` — its mean occupation is `n̄`, which is what makes the
  parameter `n̄` deserve its name;
* `thermalProb_second_moment` — its second moment is `2n̄² + n̄`;
* `thermalProb_variance` — hence its variance is `n̄² + n̄`, strictly larger than
  the Poissonian variance `n̄` of a coherent state: the thermal bath adds noise;
* `thermalTemperature` and `thermalTemperature_eq_mean_add_half` — the chapter's
  temperature is the mean occupation plus the zero-point half;
* `thermalTemperature_vacuum` — at `n̄ = 0` (no thermal bosons) the temperature is
  the pure Heisenberg floor `1/2`, matching the factor `2` in the exponent of the
  Softmax derived in `ChapterSoftmaxBorn` (`τ = 1/2`);
* `thermalTemperature_strictMono`, `half_lt_thermalTemperature` — heating the bath
  strictly raises the temperature above that floor.

**Recorded disparity with the informal chapter.**  `thermalTemperature` is a
*definition* (`n̄ ↦ n̄ + 1/2`), not a derived quantity: the physical derivation of
`τ = n̄ + 1/2` from the fidelity of displaced thermal states is the documented gap.
What is a theorem here is that the `n̄` appearing in it is genuinely the mean of
the thermal occupation distribution, and that the distribution's excess variance
over the coherent (Poisson) case is `n̄²`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterCoherentTemperature

/-- The thermal ratio `r = n̄/(n̄+1)` of the Bose–Einstein occupation
distribution. -/
def thermalRatio (nbar : ℝ) : ℝ := nbar / (nbar + 1)

/-- The **thermal occupation distribution** of a bosonic mode with mean
occupation `n̄`: the geometric law `Pr(n) = (1/(n̄+1)) · (n̄/(n̄+1))ⁿ`. -/
def thermalProb (nbar : ℝ) (n : ℕ) : ℝ := (1 / (nbar + 1)) * thermalRatio nbar ^ n

variable {nbar : ℝ}

theorem nbar_add_one_pos (h : 0 ≤ nbar) : 0 < nbar + 1 := by linarith

theorem thermalRatio_nonneg (h : 0 ≤ nbar) : 0 ≤ thermalRatio nbar :=
  div_nonneg h (le_of_lt (nbar_add_one_pos h))

theorem thermalRatio_lt_one (h : 0 ≤ nbar) : thermalRatio nbar < 1 := by
  rw [thermalRatio, div_lt_one (nbar_add_one_pos h)]
  linarith

theorem norm_thermalRatio_lt_one (h : 0 ≤ nbar) : ‖thermalRatio nbar‖ < 1 := by
  rw [Real.norm_eq_abs, abs_of_nonneg (thermalRatio_nonneg h)]
  exact thermalRatio_lt_one h

/-- `1 - r = 1/(n̄+1)`. -/
theorem one_sub_thermalRatio (h : 0 ≤ nbar) : 1 - thermalRatio nbar = 1 / (nbar + 1) := by
  rw [thermalRatio]
  field_simp
  ring

theorem thermalProb_nonneg (h : 0 ≤ nbar) (n : ℕ) : 0 ≤ thermalProb nbar n :=
  mul_nonneg (by positivity) (pow_nonneg (thermalRatio_nonneg h) n)

/-! ## Normalization and moments -/

/-- The thermal occupation distribution is a probability distribution on `ℕ`. -/
theorem thermalProb_tsum_one (h : 0 ≤ nbar) : ∑' n : ℕ, thermalProb nbar n = 1 := by
  have hr := norm_thermalRatio_lt_one h
  have hpos := nbar_add_one_pos h
  simp only [thermalProb]
  rw [tsum_mul_left, tsum_geometric_of_norm_lt_one hr, one_sub_thermalRatio h]
  field_simp

/-- **The mean occupation is `n̄`.** -/
theorem thermalProb_mean (h : 0 ≤ nbar) : ∑' n : ℕ, (n : ℝ) * thermalProb nbar n = nbar := by
  have hr := norm_thermalRatio_lt_one h
  have hpos := nbar_add_one_pos h
  have hkey : ∑' n : ℕ, (n : ℝ) * thermalProb nbar n
      = (1 / (nbar + 1)) * ∑' n : ℕ, (n : ℝ) * thermalRatio nbar ^ n := by
    rw [← tsum_mul_left]
    exact tsum_congr fun n => by simp only [thermalProb]; ring
  rw [hkey, tsum_coe_mul_geometric_of_norm_lt_one hr, one_sub_thermalRatio h, thermalRatio]
  field_simp

/-- The key summation for the second moment: `∑ (n+2 choose 2) rⁿ = 1/(1-r)³`. -/
theorem tsum_choose_two (h : 0 ≤ nbar) :
    ∑' n : ℕ, ((n + 2).choose 2 : ℝ) * thermalRatio nbar ^ n
      = 1 / (1 - thermalRatio nbar) ^ 3 :=
  tsum_choose_mul_geometric_of_norm_lt_one 2 (norm_thermalRatio_lt_one h)

/-- **The second moment is `2n̄² + n̄`.** -/
theorem thermalProb_second_moment (h : 0 ≤ nbar) :
    ∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n = 2 * nbar ^ 2 + nbar := by
  set r := thermalRatio nbar with hrdef
  have hr : ‖r‖ < 1 := norm_thermalRatio_lt_one h
  have hpos := nbar_add_one_pos h
  -- summability of the three geometric families involved
  have s0 : Summable (fun n : ℕ => r ^ n) := summable_geometric_of_norm_lt_one hr
  have s1 : Summable (fun n : ℕ => (n : ℝ) * r ^ n) :=
    (hasSum_coe_mul_geometric_of_norm_lt_one hr).summable
  have s2 : Summable (fun n : ℕ => ((n + 2).choose 2 : ℝ) * r ^ n) :=
    (hasSum_choose_mul_geometric_of_norm_lt_one 2 hr).summable
  -- `n² = 2·C(n+2,2) − 3n − 2`
  have hpoly : ∀ n : ℕ, (n : ℝ) ^ 2 * r ^ n
      = 2 * (((n + 2).choose 2 : ℝ) * r ^ n) - 3 * ((n : ℝ) * r ^ n) - 2 * r ^ n := by
    intro n
    have hc : ((n + 2).choose 2 : ℝ) = ((n : ℝ) ^ 2 + 3 * n + 2) / 2 := by
      have : (n + 2).choose 2 = (n + 2) * (n + 1) / 2 := by
        rw [Nat.choose_two_right]
        congr 1
      rw [this]
      have hdvd : 2 ∣ (n + 2) * (n + 1) := by
        rcases Nat.even_or_odd n with he | ho
        · obtain ⟨t, ht⟩ := he
          exact ⟨(t + 1) * (n + 1), by subst ht; ring⟩
        · obtain ⟨t, ht⟩ := ho
          exact ⟨(n + 2) * (t + 1), by subst ht; ring⟩
      obtain ⟨t, ht⟩ := hdvd
      rw [ht, Nat.mul_div_cancel_left _ (by norm_num)]
      have : ((n : ℝ) + 2) * ((n : ℝ) + 1) = 2 * (t : ℝ) := by
        exact_mod_cast congrArg (fun k : ℕ => (k : ℝ)) ht
      nlinarith [this]
    rw [hc]; ring
  have hsum : ∑' n : ℕ, (n : ℝ) ^ 2 * r ^ n
      = 2 * (1 / (1 - r) ^ 3) - 3 * (r / (1 - r) ^ 2) - 2 * (1 - r)⁻¹ := by
    rw [tsum_congr hpoly]
    rw [Summable.tsum_sub ((s2.mul_left 2).sub (s1.mul_left 3)) (s0.mul_left 2),
      Summable.tsum_sub (s2.mul_left 2) (s1.mul_left 3),
      s2.tsum_mul_left, s1.tsum_mul_left, s0.tsum_mul_left,
      tsum_choose_mul_geometric_of_norm_lt_one 2 hr,
      tsum_coe_mul_geometric_of_norm_lt_one hr,
      tsum_geometric_of_norm_lt_one hr]
  have hfinal : ∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n
      = (1 / (nbar + 1)) * ∑' n : ℕ, (n : ℝ) ^ 2 * r ^ n := by
    rw [← tsum_mul_left]
    exact tsum_congr fun n => by simp only [thermalProb, ← hrdef]; ring
  have h1r : 1 - r = 1 / (nbar + 1) := one_sub_thermalRatio h
  rw [hfinal, hsum, h1r, hrdef, thermalRatio]
  field_simp
  ring

/-- **The variance is `n̄² + n̄`.**  Strictly more than the Poissonian variance
`n̄` of a coherent state: the thermal bath contributes the extra `n̄²`. -/
theorem thermalProb_variance (h : 0 ≤ nbar) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n)
      - (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) ^ 2 = nbar ^ 2 + nbar := by
  rw [thermalProb_second_moment h, thermalProb_mean h]
  ring

/-! ## The temperature -/

/-- The chapter's **effective Softmax temperature** of a displaced thermal state
with mean occupation `n̄`: `τ = n̄ + 1/2`. -/
def thermalTemperature (nbar : ℝ) : ℝ := nbar + 1 / 2

/-- The temperature is the *mean occupation* of the thermal bath plus the
zero-point half.  (The mean is a theorem — `thermalProb_mean` — the split itself
is the definition; the physical derivation from displaced-thermal-state fidelity
remains a documented gap.) -/
theorem thermalTemperature_eq_mean_add_half (h : 0 ≤ nbar) :
    thermalTemperature nbar = (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) + 1 / 2 := by
  rw [thermalTemperature, thermalProb_mean h]

/-- **The vacuum case.**  With no thermal bosons the temperature is the pure
zero-point value `τ = 1/2` — exactly the temperature of the Softmax produced by
the Born rule in `ChapterSoftmaxBorn` (inverse temperature `2`). -/
theorem thermalTemperature_vacuum : thermalTemperature 0 = 1 / 2 := by
  rw [thermalTemperature]; ring

/-- Heating the bath raises the temperature. -/
theorem thermalTemperature_strictMono : StrictMono thermalTemperature := by
  intro a b hab
  simpa [thermalTemperature] using hab

/-- Any thermal bath sits strictly above the zero-point floor. -/
theorem half_lt_thermalTemperature (h : 0 < nbar) : 1 / 2 < thermalTemperature nbar := by
  rw [thermalTemperature]; linarith

end BookProof.ChapterCoherentTemperature

end
