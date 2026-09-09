import Mathlib
import BookProof.ChapterWallEsaBddBelow
import BookProof.ChapterSchrodingerCutoffEsa

/-!
# The quadratic form of `−d²/dx² + V` is bounded below when `V` is

`BookProof/ChapterWallEsaBddBelow.lean` proves that `−d²/dx² + V` is essentially
self-adjoint on the compactly supported smooth core of `L²(ℝ)` for every smooth `V`
bounded below.  Its docstring promised, but did not supply, the packaging lemma that
the shift-invert schemes need: the *quadratic form* of that operator is bounded below
by the same constant.  This module supplies it.

The content is the one-dimensional Green identity on the compactly supported smooth
core,

  `⟪(−d²/dx² + V) f, f⟫ = ∫ |f'|² + ∫ V |f|²`,

which is integration by parts once — carried out here with the compact-support
integration-by-parts engine
`BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport`.  Both terms
on the right are real, the first is `≥ 0`, and the second is `≥ -c ‖f‖²` when `V ≥ -c`.

## Contents

* `SemiboundedBelowOn` — the quadratic form of an unbounded operator on a core is
  bounded below by `-c`.
* `integral_conj_neg_deriv2_mul` — the Green identity `∫ conj(−f'') f = ∫ |f'|²` for
  a compactly supported `C²` function on the line.
* `kinCcR_quadratic_form` / `opCc_quadratic_form` / `ccEquiv_norm_sq` — the three
  pieces of the pairing as ordinary integrals.
* **`wallHamBddBelow_semibounded`** — the promised lemma: if `V ≥ -c` then the
  quadratic form of `wallHam V hV` is bounded below by `-c`.
* `wallHam_nonneg_form` — the `c = 0` case: for `V ≥ 0` the form is non-negative.

The exponential wall `eˣ + e⁻ˣ` is handled in `BookProof/ChapterExpPotentialEsa.lean`
(`expPotential_semibounded`).
-/

namespace BookProof.WallEsaSemibounded

open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The quadratic form of an unbounded operator `T`, defined on the core `D`, is
**bounded below by `-c`**: `Re ⟪T v, v⟫ ≥ -c ‖v‖²` for every `v` in the core. -/
def SemiboundedBelowOn (D : Submodule ℂ F) (T : D →ₗ[ℂ] F) (c : ℝ) : Prop :=
  ∀ v : D, -c * ‖(v : F)‖ ^ 2 ≤ (inner ℂ (T v) (v : F) : ℂ).re

/-! ## The Green identity on the compactly supported smooth core -/

/-- **Integration by parts once.**  For a compactly supported `C²` function on the line,
`∫ conj(−f'') f = ∫ |f'|²`.  Both sides are real; the statement is phrased in `ℂ` so it
can be substituted directly into an `L²` pairing. -/
theorem integral_conj_neg_deriv2_mul (f : ℝ → ℂ)
    (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f) :
    ∫ x, (starRingEnd ℂ) (-deriv (deriv f) x) * f x = ((∫ x, ‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
  have hfd : Differentiable ℝ f := hf.differentiable (by norm_num)
  have hf1 : ContDiff ℝ 1 (deriv f) := hf.deriv'
  have hf1d : Differentiable ℝ (deriv f) := hf1.differentiable one_ne_zero
  have h1 : ∀ x, HasDerivAt f (deriv f x) x := fun x => (hfd x).hasDerivAt
  have h2 : ∀ x, HasDerivAt (deriv f) (deriv (deriv f) x) x := fun x => (hf1d x).hasDerivAt
  have hcont0 : Continuous f := hfd.continuous
  have hcont1 : Continuous (deriv f) := hf1d.continuous
  have hcont2 : Continuous (deriv (deriv f)) := hf1.continuous_deriv le_rfl
  have hs1 : HasCompactSupport (deriv f) := hs.deriv
  -- the energy density and its derivative
  set g : ℝ → ℂ := fun x => (starRingEnd ℂ) (deriv f x) * f x with hgdef
  set g' : ℝ → ℂ := fun x =>
    (starRingEnd ℂ) (deriv (deriv f) x) * f x + ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) with hg'def
  have hgderiv : ∀ x, HasDerivAt g (g' x) x := by
    intro x
    have hstar : HasDerivAt (fun y => (starRingEnd ℂ) (deriv f y))
        ((starRingEnd ℂ) (deriv (deriv f) x)) x := (h2 x).star
    have hmul := hstar.mul (h1 x)
    have hsq : (starRingEnd ℂ) (deriv f x) * deriv f x = ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
      rw [Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
    simpa [hgdef, hg'def, hsq] using hmul
  have hg'cont : Continuous g' := by
    simp only [hg'def]
    fun_prop
  have hgsupp : HasCompactSupport g := hs.mul_left
  have hzero : ∫ x, g' x = 0 :=
    BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport hgderiv hg'cont hgsupp
  -- split the integral
  have hIa : Integrable fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x
      ).integrable_of_hasCompactSupport hs.mul_left
  have hIb : Integrable fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) :=
    (by fun_prop : Continuous fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)
      ).integrable_of_hasCompactSupport (by
        exact hs1.comp_left (g := fun z : ℂ => ((‖z‖ ^ 2 : ℝ) : ℂ)) (by simp))
  have hsplit : (∫ x, g' x)
      = (∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x)
        + ∫ x, ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
    simp only [hg'def]
    exact integral_add hIa hIb
  rw [hsplit] at hzero
  have hreal : (∫ x, ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)) = ((∫ x, ‖deriv f x‖ ^ 2 : ℝ) : ℂ) :=
    integral_complex_ofReal
  rw [hreal] at hzero
  have hneg : (∫ x, (starRingEnd ℂ) (-deriv (deriv f) x) * f x)
      = -∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x := by
    rw [← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp
  rw [hneg]
  linear_combination -hzero

/-! ## The three pieces of the pairing -/

/-- The `L²` square norm of a Schwartz function, as an integral. -/
theorem inner_toLp_self (g : 𝓢(ℝ, ℂ)) :
    (inner ℂ (g.toLp 2 (volume : Measure ℝ)) (g.toLp 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖g x‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_toLp_left]
  rw [← integral_complex_ofReal]
  refine integral_congr_ae ?_
  filter_upwards [g.coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]

/-- The kinetic quadratic form on the compactly supported smooth core is the Dirichlet
energy. -/
theorem kinCcR_quadratic_form (f : ccSchwartz ℝ) :
    (inner ℂ (kinCcR (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 : ℝ) : ℂ) := by
  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ f)
      = schwartzEquiv ℝ (f : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ f)
      = (kinOpR (f : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  rw [hkin, ccEquiv_coe, inner_toLp_left]
  rw [show (∫ x, (starRingEnd ℂ) ((kinOpR (f : 𝓢(ℝ, ℂ))) x)
        * ((f : 𝓢(ℝ, ℂ)).toLp 2 (volume : Measure ℝ) : ℝ → ℂ) x)
      = ∫ x, (starRingEnd ℂ) (-deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) x)
          * ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x from ?_]
  · exact integral_conj_neg_deriv2_mul _ ((f : 𝓢(ℝ, ℂ)).smooth 2) f.2
  refine integral_congr_ae ?_
  filter_upwards [(f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx, kinOpR_apply]

/-- The potential quadratic form on the compactly supported smooth core. -/
theorem opCc_quadratic_form (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (f : ccSchwartz ℝ) :
    (inner ℂ (opCc V hV (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by
  rw [opCc_apply, ccEquiv_coe, inner_toLp_left, ← integral_complex_ofReal]
  refine integral_congr_ae ?_
  filter_upwards [(f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx]
  simp only [mulCc_apply, map_mul, Complex.conj_ofReal, Complex.ofReal_mul]
  rw [mul_assoc, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]

/-- The `L²` square norm of an element of the compactly supported smooth core. -/
theorem ccEquiv_norm_sq (f : ccSchwartz ℝ) :
    ‖((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
      = ∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  have h := inner_toLp_self (f : 𝓢(ℝ, ℂ))
  rw [← ccEquiv_coe] at h
  rw [← inner_self_eq_norm_sq (𝕜 := ℂ)
    ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)), h]
  simp

/-! ## The packaging lemma -/

/-- **The quadratic form of `−d²/dx² + V` is bounded below by `-c` when `V ≥ -c`.**
This is the semiboundedness the shift-invert (Hashimoto/SIRK) schemes work with: together
with `wallHam_essentiallySelfAdjoint_of_bddBelow` it says that the closed operator selected
by the closure of `wallHam V hV` is the semibounded one. -/
theorem wallHamBddBelow_semibounded (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
    SemiboundedBelowOn (ccDomain ℝ) (wallHam V hV) c := by
  intro v
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective v
  have hk := kinCcR_quadratic_form f
  have hp := opCc_quadratic_form V hV f
  have hn := ccEquiv_norm_sq f
  have hcf : Continuous ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) := (f : 𝓢(ℝ, ℂ)).continuous
  have hsq : Continuous fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by fun_prop
  have hsupp : HasCompactSupport fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    f.2.comp_left (g := fun z : ℂ => ‖z‖ ^ 2) (by simp)
  have hI0 : Integrable fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    hsq.integrable_of_hasCompactSupport hsupp
  have hIV : Integrable fun x => V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    ((hV.continuous.mul hsq)).integrable_of_hasCompactSupport hsupp.mul_left
  have hIc : Integrable fun x => -c * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := hI0.const_mul _
  have hkin_nonneg : (0 : ℝ) ≤ ∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 :=
    integral_nonneg fun x => by positivity
  have hpot : (-c) * (∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      ≤ ∫ x, V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    rw [← integral_const_mul]
    exact integral_mono hIc hIV fun x => by
      have := hVc x
      nlinarith [sq_nonneg ‖(f : 𝓢(ℝ, ℂ)) x‖, norm_nonneg ((f : 𝓢(ℝ, ℂ)) x)]
  simp only [wallHam, LinearMap.add_apply, inner_add_left, hk, hp, hn]
  simp only [Complex.add_re, Complex.ofReal_re]
  linarith

/-- The non-negative case: for `V ≥ 0` the quadratic form of `−d²/dx² + V` is
non-negative on the compactly supported smooth core. -/
theorem wallHam_nonneg_form (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (hVnn : ∀ x, 0 ≤ V x) :
    SemiboundedBelowOn (ccDomain ℝ) (wallHam V hV) 0 :=
  wallHamBddBelow_semibounded V hV fun x => by simpa using hVnn x

end

end BookProof.WallEsaSemibounded
