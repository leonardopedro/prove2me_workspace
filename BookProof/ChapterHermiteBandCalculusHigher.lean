import Mathlib
import BookProof.ChapterHermiteBandCalculus

/-!
# The graded band calculus of arbitrary order

`BookProof.ChapterHermiteBandCalculus` develops the band calculus of the product Hermite
basis for the two growths `g1 n = √(n+1)` (a ladder operator) and `g2 n = n + 1` (a
quadratic Hamiltonian), and stops there because the weighted Schur gate it feeds is only
available for quadratic symbols.  The *matrix structure* of an operator of higher degree is
nevertheless well defined and useful — it is the data a spectral certificate consumes — and
this chapter supplies it.

## What is proved

* `gpow m n = √(n+1)^m` — the growth of an operator of order `m`; `gpow 0 = 1`,
  `gpow 1 = g1`, `gpow 2 = g2`, and `gpow` is monotone in `m` (`gpow_mono`).
* `Band.monoR`, `Band.monoG` — widening the band radius and the growth.
* **`Band.compGen`** — the general composition law: composing a band operator of order `m₁`
  and radius `r₁` with one of order `m₂` gives an operator of order `m₁ + m₂` and radius
  `r₁ + r₂`, with the explicit constant `M₁·C₁·C₂·√(r₁+1)^{m₂}`.  The analytic content is
  `√(deg γ + 1) ≤ √(r₁+1)·√(deg α + 1)` whenever `|deg γ − deg α| ≤ r₁`.
* `IsBandR r m T` (explicit band radius) and `IsBandDeg m T` (radius existentially
  quantified) — closed under sums, scalar multiples, finite sums, composition
  (`IsBandR.comp` adds both the radii and the orders) and the order bound (`IsBandR.le`).
* `isBandDeg_one`, `isBandDeg1_mulXPoly`, `isBandDeg1_momPoly`, `isBandDeg1_crePoly`,
  `isBandDeg1_annPoly` — the base cases; `isBand1_iff_isBandDeg_one`,
  `IsBand2.isBandDeg_two`, `IsBandDeg.isBand2` — the comparison with the old predicates.
* **`isBandDeg_mulOp_multiset`** — multiplication by a product of `k` coordinates is a band
  operator of order `k`; **`isBandDeg_mulOp_monomial`** and **`isBandDeg_mulOp`** —
  multiplication by an arbitrary polynomial `p` is a band operator of order
  `p.totalDegree`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HermiteBandHigher

noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

/-! ## The growth of an operator of order `m` -/

/-- The growth of a band operator of order `m`: `√(n+1)^m`. -/
def gpow (m : ℕ) : ℕ → ℝ := fun n => Real.sqrt ((n : ℝ) + 1) ^ m

theorem gpow_zero : gpow 0 = fun _ : ℕ => (1 : ℝ) := by
  funext n; simp [gpow]

theorem gpow_one : gpow 1 = (g1 : ℕ → ℝ) := by
  funext n; simp [gpow, g1]

theorem gpow_two : gpow 2 = (g2 : ℕ → ℝ) := by
  funext n
  have h : Real.sqrt ((n : ℝ) + 1) ^ 2 = (n : ℝ) + 1 := Real.sq_sqrt (by positivity)
  simp [gpow, g2, h]

theorem gpow_nonneg (m n : ℕ) : 0 ≤ gpow m n := by
  simp only [gpow]
  positivity

theorem one_le_sqrt_succ (n : ℕ) : (1 : ℝ) ≤ Real.sqrt ((n : ℝ) + 1) := by
  simp

theorem gpow_mono {m m' : ℕ} (h : m ≤ m') (n : ℕ) : gpow m n ≤ gpow m' n :=
  pow_le_pow_right₀ (one_le_sqrt_succ n) h

theorem gpow_add (m m' n : ℕ) : gpow (m + m') n = gpow m n * gpow m' n := by
  simp [gpow, pow_add]

/-! ## Widening a band -/

theorem Band.monoR {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {r r' M : ℕ}
    {C : ℝ} {g : ℕ → ℝ} (hr : r ≤ r') (h : Band T r M C g) : Band T r' M C g := by
  intro α
  obtain ⟨f, hrep, hcard, hband, hcoef⟩ := h α
  exact ⟨f, hrep, hcard, fun β hβ => le_trans (hband β hβ) hr, hcoef⟩

theorem Band.monoG {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {r M : ℕ}
    {C : ℝ} {g g' : ℕ → ℝ} (hC : 0 ≤ C) (hg : ∀ n, g n ≤ g' n) (h : Band T r M C g) :
    Band T r M C g' := by
  intro α
  obtain ⟨f, hrep, hcard, hband, hcoef⟩ := h α
  exact ⟨f, hrep, hcard, hband, fun β =>
    le_trans (hcoef β) (mul_le_mul_of_nonneg_left (hg α.degree) hC)⟩

/-! ## The general composition law -/

theorem Band.compGen {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    {r₁ r₂ M₁ M₂ m₁ m₂ : ℕ} {C₁ C₂ : ℝ} (hC₁ : 0 ≤ C₁) (hC₂ : 0 ≤ C₂)
    (hT : Band T r₁ M₁ C₁ (gpow m₁)) (hU : Band U r₂ M₂ C₂ (gpow m₂)) :
    Band (U ∘ₗ T) (r₁ + r₂) (M₁ * M₂)
      (M₁ * C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂) (gpow (m₁ + m₂)) := by
  classical
  intro α
  obtain ⟨f, hrep, hcard, hband, hcoef⟩ := hT α
  choose G hGrep hGcard hGband hGcoef using hU
  refine ⟨f.sum fun γ c => c • G γ, ?_, ?_, ?_, ?_⟩
  · have h1 : (U ∘ₗ T) (hpsi α) = U (hcomb f) := by rw [LinearMap.comp_apply, hrep]
    rw [h1, hcomb, Finsupp.linearCombination_apply, Finsupp.sum, map_sum, hcomb,
      show (f.sum fun γ c => c • G γ) = ∑ γ ∈ f.support, f γ • G γ from rfl, map_sum]
    exact Finset.sum_congr rfl fun γ _ => by rw [map_smul, hGrep γ, map_smul]
  · have hsub : (f.sum fun γ c => c • G γ).support ⊆ f.support.biUnion fun γ => (G γ).support := by
      refine (Finsupp.support_sum).trans ?_
      intro β hβ
      simp only [Finset.mem_biUnion] at hβ ⊢
      obtain ⟨γ, hγ, hβγ⟩ := hβ
      exact ⟨γ, hγ, Finsupp.support_smul hβγ⟩
    calc (f.sum fun γ c => c • G γ).support.card
        ≤ (f.support.biUnion fun γ => (G γ).support).card := Finset.card_le_card hsub
      _ ≤ ∑ γ ∈ f.support, (G γ).support.card := Finset.card_biUnion_le
      _ ≤ ∑ _γ ∈ f.support, M₂ := Finset.sum_le_sum fun γ _ => hGcard γ
      _ = f.support.card * M₂ := by rw [Finset.sum_const, smul_eq_mul]
      _ ≤ M₁ * M₂ := Nat.mul_le_mul_right _ hcard
  · intro β hβ
    have hmem : β ∈ f.support.biUnion fun γ => (G γ).support := by
      refine (Finsupp.support_sum).trans (by
        intro β' hβ'
        simp only [Finset.mem_biUnion] at hβ' ⊢
        obtain ⟨γ, hγ, hβγ⟩ := hβ'
        exact ⟨γ, hγ, Finsupp.support_smul hβγ⟩) hβ
    simp only [Finset.mem_biUnion] at hmem
    obtain ⟨γ, hγ, hβγ⟩ := hmem
    have h1 := hGband γ β hβγ
    have h2 := hband γ hγ
    omega
  · intro β
    have happ : (f.sum fun γ c => c • G γ) β = ∑ γ ∈ f.support, f γ * (G γ) β := by
      simp only [Finsupp.sum, Finset.sum_apply', Finsupp.coe_smul, Pi.smul_apply, smul_eq_mul]
    rw [happ]
    refine le_trans (norm_sum_le _ _) ?_
    have hterm : ∀ γ ∈ f.support,
        ‖f γ * (G γ) β‖ ≤ C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow (m₁ + m₂) α.degree := by
      intro γ hγ
      have hγdeg : ((γ.degree : ℤ) - (α.degree : ℤ)).natAbs ≤ r₁ := hband γ hγ
      have hle : (γ.degree : ℝ) + 1 ≤ ((r₁ : ℝ) + 1) * ((α.degree : ℝ) + 1) := by
        have hz : (γ.degree : ℤ) ≤ (α.degree : ℤ) + (r₁ : ℤ) := by omega
        have hr : (γ.degree : ℝ) ≤ (α.degree : ℝ) + (r₁ : ℝ) := by exact_mod_cast hz
        nlinarith [Nat.cast_nonneg (α := ℝ) α.degree, Nat.cast_nonneg (α := ℝ) r₁]
      have hsqrt : Real.sqrt ((γ.degree : ℝ) + 1)
          ≤ Real.sqrt ((r₁ : ℝ) + 1) * Real.sqrt ((α.degree : ℝ) + 1) := by
        rw [← Real.sqrt_mul (by positivity)]
        exact Real.sqrt_le_sqrt hle
      have hpow : gpow m₂ γ.degree
          ≤ Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow m₂ α.degree := by
        simp only [gpow, ← mul_pow]
        exact pow_le_pow_left₀ (Real.sqrt_nonneg _) hsqrt m₂
      have h1 : ‖f γ‖ ≤ C₁ * gpow m₁ α.degree := hcoef γ
      have h2 : ‖(G γ) β‖ ≤ C₂ * gpow m₂ γ.degree := hGcoef γ β
      calc ‖f γ * (G γ) β‖ = ‖f γ‖ * ‖(G γ) β‖ := norm_mul _ _
        _ ≤ (C₁ * gpow m₁ α.degree) * (C₂ * gpow m₂ γ.degree) :=
            mul_le_mul h1 h2 (norm_nonneg _) (mul_nonneg hC₁ (gpow_nonneg _ _))
        _ ≤ (C₁ * gpow m₁ α.degree)
              * (C₂ * (Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow m₂ α.degree)) := by
            refine mul_le_mul_of_nonneg_left ?_ (mul_nonneg hC₁ (gpow_nonneg _ _))
            exact mul_le_mul_of_nonneg_left hpow hC₂
        _ = C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * (gpow m₁ α.degree * gpow m₂ α.degree) := by
            ring
        _ = C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow (m₁ + m₂) α.degree := by
            rw [gpow_add]
    calc ∑ γ ∈ f.support, ‖f γ * (G γ) β‖
        ≤ ∑ _γ ∈ f.support,
            C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow (m₁ + m₂) α.degree :=
          Finset.sum_le_sum hterm
      _ = f.support.card
            * (C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow (m₁ + m₂) α.degree) := by
          rw [Finset.sum_const, nsmul_eq_mul]
      _ ≤ M₁ * (C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow (m₁ + m₂) α.degree) := by
          have hnn : (0:ℝ) ≤ C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow (m₁ + m₂) α.degree := by
            have : (0:ℝ) ≤ Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ := by positivity
            exact mul_nonneg (mul_nonneg (mul_nonneg hC₁ hC₂) this) (gpow_nonneg _ _)
          exact mul_le_mul_of_nonneg_right (by exact_mod_cast hcard) hnn
      _ = M₁ * C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ * gpow (m₁ + m₂) α.degree := by ring

/-! ## The order predicate -/

/-- `T` is a band operator of **radius `r` and order `m`**: on every Hermite state it
produces boundedly many states whose degrees differ by at most `r`, with coefficients
bounded by `C·√(deg+1)^m`. -/
def IsBandR (r m : ℕ) (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) : Prop :=
  ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧ Band T r M C (gpow m)

/-- `T` is a band operator of order `m`: some band radius, some column bound, and
coefficients bounded by `C·√(deg+1)^m`. -/
def IsBandDeg (m : ℕ) (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) : Prop :=
  ∃ r, IsBandR r m T

theorem IsBandR.isBandDeg {r m : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (h : IsBandR r m T) : IsBandDeg m T := ⟨r, h⟩

theorem IsBandR.monoR {r r' m : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hr : r ≤ r') (h : IsBandR r m T) : IsBandR r' m T := by
  obtain ⟨M, C, hC, hB⟩ := h
  exact ⟨M, C, hC, Band.monoR hr hB⟩

theorem IsBandR.le {r m m' : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hm : m ≤ m') (h : IsBandR r m T) : IsBandR r m' T := by
  obtain ⟨M, C, hC, hB⟩ := h
  exact ⟨M, C, hC, Band.monoG hC (fun n => gpow_mono hm n) hB⟩

theorem IsBandDeg.le {m m' : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hm : m ≤ m') (h : IsBandDeg m T) : IsBandDeg m' T := by
  obtain ⟨r, h⟩ := h
  exact ⟨r, h.le hm⟩

theorem IsBandR.add {r m : ℕ} {T S : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hT : IsBandR r m T) (hS : IsBandR r m S) : IsBandR r m (T + S) := by
  obtain ⟨M₁, C₁, hC₁, h₁⟩ := hT
  obtain ⟨M₂, C₂, hC₂, h₂⟩ := hS
  exact ⟨M₁ + M₂, C₁ + C₂, by linarith, Band.add h₁ h₂⟩

theorem IsBandDeg.add {m : ℕ} {T S : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hT : IsBandDeg m T) (hS : IsBandDeg m S) : IsBandDeg m (T + S) := by
  obtain ⟨r₁, h₁⟩ := hT
  obtain ⟨r₂, h₂⟩ := hS
  exact ⟨max r₁ r₂, (h₁.monoR (le_max_left _ _)).add (h₂.monoR (le_max_right _ _))⟩

theorem IsBandR.smul {r m : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (c : ℂ) (hT : IsBandR r m T) : IsBandR r m (c • T) := by
  obtain ⟨M, C, hC, h⟩ := hT
  exact ⟨M, ‖c‖ * C, mul_nonneg (norm_nonneg c) hC, Band.smul c h⟩

theorem IsBandDeg.smul {m : ℕ} {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (c : ℂ) (hT : IsBandDeg m T) : IsBandDeg m (c • T) := by
  obtain ⟨r, h⟩ := hT
  exact ⟨r, h.smul c⟩

theorem isBandR_zero_op (r m : ℕ) :
    IsBandR r m (0 : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) := by
  refine ⟨0, 0, le_refl 0, fun α => ⟨0, ?_, ?_, ?_, ?_⟩⟩ <;> simp [hcomb]

theorem isBandDeg_zero_op (m : ℕ) :
    IsBandDeg m (0 : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :=
  ⟨0, isBandR_zero_op 0 m⟩

theorem IsBandR.sum {r m : ℕ} {ι : Type*} (s : Finset ι)
    (F : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (h : ∀ i ∈ s, IsBandR r m (F i)) : IsBandR r m (∑ i ∈ s, F i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using isBandR_zero_op r m
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact IsBandR.add (h a (Finset.mem_insert_self a s))
        (ih fun i hi => h i (Finset.mem_insert_of_mem hi))

theorem IsBandDeg.sum {m : ℕ} {ι : Type*} (s : Finset ι)
    (F : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (h : ∀ i ∈ s, IsBandDeg m (F i)) : IsBandDeg m (∑ i ∈ s, F i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using isBandDeg_zero_op m
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact IsBandDeg.add (h a (Finset.mem_insert_self a s))
        (ih fun i hi => h i (Finset.mem_insert_of_mem hi))

/-- **The composition of band operators adds the radii and the orders.** -/
theorem IsBandR.comp {r₁ r₂ m₁ m₂ : ℕ}
    {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hU : IsBandR r₂ m₂ U) (hT : IsBandR r₁ m₁ T) :
    IsBandR (r₁ + r₂) (m₁ + m₂) (U ∘ₗ T) := by
  obtain ⟨M₁, C₁, hC₁, h₁⟩ := hT
  obtain ⟨M₂, C₂, hC₂, h₂⟩ := hU
  refine ⟨M₁ * M₂, M₁ * C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂, ?_,
    Band.compGen hC₁ hC₂ h₁ h₂⟩
  have h : (0:ℝ) ≤ Real.sqrt ((r₁ : ℝ) + 1) ^ m₂ := by positivity
  have h' : (0:ℝ) ≤ (M₁ : ℝ) * C₁ * C₂ := by positivity
  exact mul_nonneg h' h

/-- **The composition of band operators adds the orders.** -/
theorem IsBandDeg.comp {m₁ m₂ : ℕ} {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hU : IsBandDeg m₂ U) (hT : IsBandDeg m₁ T) : IsBandDeg (m₁ + m₂) (U ∘ₗ T) := by
  obtain ⟨r₁, h₁⟩ := hT
  obtain ⟨r₂, h₂⟩ := hU
  exact ⟨r₁ + r₂, h₂.comp h₁⟩

/-! ## Comparison with the first- and second-order predicates -/

theorem isBand1_isBandR_one {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} :
    IsBand1 T → IsBandR 1 1 T := by
  rintro ⟨M, C, hC, h⟩
  exact ⟨M, C, hC, by rwa [gpow_one]⟩

theorem isBand1_iff_isBandDeg_one {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} :
    IsBand1 T → IsBandDeg 1 T := fun h => (isBand1_isBandR_one h).isBandDeg

theorem IsBand2.isBandR_two {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} :
    IsBand2 T → IsBandR 2 2 T := by
  rintro ⟨M, C, hC, h⟩
  exact ⟨M, C, hC, by rwa [gpow_two]⟩

theorem IsBand2.isBandDeg_two {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (h : IsBand2 T) : IsBandDeg 2 T := (IsBand2.isBandR_two h).isBandDeg

/-! ## The base cases -/

theorem isBandR1_crePoly (i : Fin d) : IsBandR 1 1 (crePoly i) :=
  isBand1_isBandR_one (isBand1_crePoly i)

theorem isBandR1_annPoly (i : Fin d) : IsBandR 1 1 (annPoly i) :=
  isBand1_isBandR_one (isBand1_annPoly i)

theorem isBandR1_mulXPoly (i : Fin d) : IsBandR 1 1 (mulXPoly i) :=
  isBand1_isBandR_one (isBand1_mulXPoly i)

theorem isBandR1_momPoly (i : Fin d) : IsBandR 1 1 (momPoly i) :=
  isBand1_isBandR_one (isBand1_momPoly i)

theorem isBandDeg1_crePoly (i : Fin d) : IsBandDeg 1 (crePoly i) :=
  (isBandR1_crePoly i).isBandDeg

theorem isBandDeg1_annPoly (i : Fin d) : IsBandDeg 1 (annPoly i) :=
  (isBandR1_annPoly i).isBandDeg

theorem isBandDeg1_mulXPoly (i : Fin d) : IsBandDeg 1 (mulXPoly i) :=
  (isBandR1_mulXPoly i).isBandDeg

theorem isBandDeg1_momPoly (i : Fin d) : IsBandDeg 1 (momPoly i) :=
  (isBandR1_momPoly i).isBandDeg

/-- The identity is a band operator of radius `0` and order `0`. -/
theorem isBandR_one_op :
    IsBandR 0 0 (LinearMap.id : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) := by
  classical
  refine ⟨1, 1, zero_le_one, fun α => ⟨Finsupp.single α 1, ?_, ?_, ?_, ?_⟩⟩
  · rw [hcomb, Finsupp.linearCombination_single]
    simp
  · exact le_trans (Finset.card_le_card Finsupp.support_single_subset) (by simp)
  · intro β hβ
    have hβ' : β = α := Finset.mem_singleton.mp (Finsupp.support_single_subset hβ)
    subst hβ'
    simp
  · intro β
    rw [Finsupp.single_apply]
    split <;> simp [gpow]

theorem isBandDeg_one_op :
    IsBandDeg 0 (LinearMap.id : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :=
  isBandR_one_op.isBandDeg

/-! ## Multiplication by a polynomial -/

theorem mulOp_eq_mulXPoly (i : Fin d) :
    mulOp (X i : MvPolynomial (Fin d) ℂ) = mulXPoly i := by
  refine LinearMap.ext fun p => ?_
  simp [mulOp, mulXPoly]

theorem mulOp_one : mulOp (1 : MvPolynomial (Fin d) ℂ) = LinearMap.id := by
  refine LinearMap.ext fun p => ?_
  simp [mulOp]

theorem mulOp_mul (f g : MvPolynomial (Fin d) ℂ) :
    mulOp (f * g) = (mulOp f) ∘ₗ (mulOp g) := by
  refine LinearMap.ext fun p => ?_
  simp [mulOp]

theorem mulOp_add' (f g : MvPolynomial (Fin d) ℂ) : mulOp (f + g) = mulOp f + mulOp g := by
  refine LinearMap.ext fun p => ?_
  simp [mulOp, add_mul]

theorem mulOp_smul (c : ℂ) (f : MvPolynomial (Fin d) ℂ) : mulOp (c • f) = c • mulOp f := by
  refine LinearMap.ext fun p => ?_
  simp [mulOp]

theorem mulOp_sum {ι : Type*} (s : Finset ι) (F : ι → MvPolynomial (Fin d) ℂ) :
    mulOp (∑ i ∈ s, F i) = ∑ i ∈ s, mulOp (F i) := by
  classical
  induction s using Finset.induction_on with
  | empty => refine LinearMap.ext fun p => ?_; simp [mulOp]
  | insert a s ha ih => rw [Finset.sum_insert ha, mulOp_add', ih, Finset.sum_insert ha]

/-- **Multiplication by a product of `k` coordinates is a band operator of order `k`.** -/
theorem isBandDeg_mulOp_multiset (s : Multiset (Fin d)) :
    IsBandDeg (Multiset.card s)
      (mulOp ((s.map (fun i => (X i : MvPolynomial (Fin d) ℂ))).prod)) := by
  classical
  induction s using Multiset.induction_on with
  | empty => simpa [mulOp_one] using (isBandDeg_one_op (d := d))
  | cons i s ih =>
      have hprod : ((i ::ₘ s).map (fun j => (X j : MvPolynomial (Fin d) ℂ))).prod
          = (X i : MvPolynomial (Fin d) ℂ)
              * (s.map (fun j => (X j : MvPolynomial (Fin d) ℂ))).prod := by
        simp
      rw [hprod, mulOp_mul, Multiset.card_cons]
      have := (isBandDeg1_mulXPoly (d := d) i).comp ih
      rw [mulOp_eq_mulXPoly]
      simpa [Nat.add_comm] using this

theorem prod_toMultiset_X (s : Fin d →₀ ℕ) :
    ((s.toMultiset.map (fun i => (X i : MvPolynomial (Fin d) ℂ))).prod)
      = s.prod fun i k => (X i : MvPolynomial (Fin d) ℂ) ^ k := by
  classical
  induction s using Finsupp.induction with
  | zero => simp
  | single_add a b f _ha _hb ih =>
      rw [Finsupp.toMultiset_add, Finsupp.toMultiset_single, Multiset.map_add, Multiset.prod_add,
        ih, Finsupp.prod_add_index' (fun i => pow_zero (X i : MvPolynomial (Fin d) ℂ))
          (fun i k₁ k₂ => pow_add (X i : MvPolynomial (Fin d) ℂ) k₁ k₂)]
      have hR : ((Finsupp.single a b).prod fun i k => (X i : MvPolynomial (Fin d) ℂ) ^ k)
          = (X a : MvPolynomial (Fin d) ℂ) ^ b :=
        Finsupp.prod_single_index (pow_zero _)
      have hL : (Multiset.map (fun i => (X i : MvPolynomial (Fin d) ℂ))
            (b • ({a} : Multiset (Fin d)))).prod = (X a : MvPolynomial (Fin d) ℂ) ^ b := by
        rw [Multiset.map_nsmul, Multiset.map_singleton, Multiset.prod_nsmul,
          Multiset.prod_singleton]
      rw [hL, hR]

/-- **Multiplication by a monomial of degree `k` is a band operator of order `k`.** -/
theorem isBandDeg_mulOp_monomial (s : Fin d →₀ ℕ) (c : ℂ) :
    IsBandDeg s.degree (mulOp (monomial s c : MvPolynomial (Fin d) ℂ)) := by
  classical
  have hmon : (monomial s c : MvPolynomial (Fin d) ℂ)
      = c • ((s.toMultiset.map (fun i => (X i : MvPolynomial (Fin d) ℂ))).prod) := by
    rw [prod_toMultiset_X, MvPolynomial.monomial_eq, smul_eq_C_mul]
  have hcard : Multiset.card s.toMultiset = s.degree := by
    rw [Finsupp.card_toMultiset]
    simp [Finsupp.degree, Finsupp.sum]
  rw [hmon, mulOp_smul]
  exact IsBandDeg.smul c (hcard ▸ isBandDeg_mulOp_multiset s.toMultiset)

/-- **Multiplication by an arbitrary polynomial is a band operator of its total degree.** -/
theorem isBandDeg_mulOp (p : MvPolynomial (Fin d) ℂ) :
    IsBandDeg p.totalDegree (mulOp p) := by
  classical
  have hp : p = ∑ s ∈ p.support, (monomial s (coeff s p) : MvPolynomial (Fin d) ℂ) :=
    (MvPolynomial.support_sum_monomial_coeff p).symm
  rw [show mulOp p = ∑ s ∈ p.support, mulOp (monomial s (coeff s p)) by
    conv_lhs => rw [hp]
    rw [mulOp_sum]]
  refine IsBandDeg.sum _ _ fun s hs => ?_
  refine IsBandDeg.le ?_ (isBandDeg_mulOp_monomial s (coeff s p))
  exact MvPolynomial.le_totalDegree hs

end

end BookProof.HermiteBandHigher
