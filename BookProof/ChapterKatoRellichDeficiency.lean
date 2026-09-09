import Mathlib
import BookProof.ChapterFarisLavine

/-!
# Bounded symmetric perturbations preserve essential self-adjointness

This module proves the **Kato–Rellich theorem** in the special case of a *bounded*
symmetric perturbation, in the deficiency-space formulation used throughout this
project (`BookProof.FarisLavine.EssentiallySelfAdjointOn`):

> If `H` is symmetric on a domain `D` and essentially self-adjoint, and `B` is a bounded
> everywhere-defined symmetric operator, then `H + B` is essentially self-adjoint on `D`.

No closure or spectral theory is needed.  The proof is an explicit Neumann-series
argument at the level of *finite* sums, which keeps every approximant inside the domain
`D`:

* For a symmetric `H` one has `‖H x - e i x‖ ≥ |e| ‖x‖` (`FarisLavine.norm_sub_smul_sq`),
  so an approximate solution of `(H - e i) x = v` has controlled norm.
* Given `y`, solve `(H - e i) v₀ ≈ y`, then `(H - e i) v₁ ≈ -B v₀`, and so on.  The
  partial sums `Sₘ = v₀ + ⋯ + v_{m-1}` satisfy `(H + B - e i) Sₘ ≈ y - rₘ` where the
  residuals `rₘ` decay geometrically with ratio `‖B‖/|e| < 1`.
* Hence the range of `H + B - e i` is dense whenever `|e| > ‖B‖`, and this gives
  vanishing deficiency spaces at `± e i`; the basic criterion
  `FarisLavine.deficiencyTrivialAt_of_dense_range` then propagates this to every
  non-real point, in particular to `± i`.
-/

namespace BookProof.KatoRellich

open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- Dense range of `T - conj z` gives a trivial deficiency space at `z`. -/
theorem deficiencyTrivialAt_of_dense (T : D →ₗ[ℂ] F) (z : ℂ)
    (hd : Dense (Set.range fun x : D => T x - ((starRingEnd ℂ) z) • (x : F))) :
    DeficiencyTrivialAt D T z := by
  intro w hw
  have hclosed : IsClosed {y : F | (inner ℂ y w : ℂ) = 0} :=
    isClosed_eq (Continuous.inner continuous_id continuous_const) continuous_const
  have hsub : (Set.range fun x : D => T x - ((starRingEnd ℂ) z) • (x : F))
      ⊆ {y : F | (inner ℂ y w : ℂ) = 0} := by
    rintro _ ⟨x, rfl⟩
    simp only [Set.mem_setOf_eq, inner_sub_left, inner_smul_left, hw x, Complex.conj_conj]
    ring
  have huniv := hclosed.closure_subset_iff.mpr hsub
  rw [hd.closure_eq] at huniv
  exact inner_self_eq_zero.mp (huniv (Set.mem_univ w))

/-- **The Neumann-series step.**  If the range of `H - e i` is dense and `B` is bounded
with `‖B‖ < |e|`, then the range of `H + B - e i` is dense as well.  All approximants are
finite sums of elements of the domain, so no closure of `H` is involved. -/
theorem dense_range_add_bounded (H : D →ₗ[ℂ] F) (hH : SymmetricOn D H)
    (B : F →L[ℂ] F) (e : ℝ) (he : ‖B‖ < |e|)
    (hdense : Dense (Set.range fun x : D => H x - ((e : ℂ) * Complex.I) • (x : F))) :
    Dense (Set.range fun x : D => (H x + B (x : F)) - ((e : ℂ) * Complex.I) • (x : F)) := by
  have he0 : (0 : ℝ) < |e| := lt_of_le_of_lt (norm_nonneg B) he
  set lam : ℂ := (e : ℂ) * Complex.I with hlam
  set q : ℝ := ‖B‖ / |e| with hqdef
  have hq0 : 0 ≤ q := div_nonneg (norm_nonneg B) he0.le
  have hq1 : q < 1 := (div_lt_one he0).mpr he
  -- the lower bound `|e| ‖x‖ ≤ ‖H x - e i x‖`
  have hlow : ∀ x : D, |e| * ‖(x : F)‖ ≤ ‖H x - lam • (x : F)‖ := by
    intro x
    have h := norm_sub_smul_sq H hH e x
    have hsq : (|e| * ‖(x : F)‖) ^ 2 ≤ ‖H x - lam • (x : F)‖ ^ 2 := by
      rw [hlam, h, mul_pow, sq_abs]
      nlinarith [sq_nonneg ‖H x‖]
    nlinarith [norm_nonneg (H x - lam • (x : F)),
      mul_nonneg (abs_nonneg e) (norm_nonneg (x : F))]
  rw [Metric.dense_iff]
  intro y r hr
  -- choose the number of Neumann steps and the accuracy of each step
  obtain ⟨n, hn0⟩ : ∃ n : ℕ, q ^ n < (r / 2) / (‖y‖ + 1) :=
    exists_pow_lt_of_lt_one (by positivity) hq1
  have hn : q ^ n * ‖y‖ < r / 2 := by
    have h1 : q ^ n * ‖y‖ ≤ q ^ n * (‖y‖ + 1) := by
      have := pow_nonneg hq0 n
      nlinarith [norm_nonneg y]
    have h2 : q ^ n * (‖y‖ + 1) < ((r / 2) / (‖y‖ + 1)) * (‖y‖ + 1) := by
      have : (0 : ℝ) < ‖y‖ + 1 := by positivity
      exact mul_lt_mul_of_pos_right hn0 this
    have h3 : ((r / 2) / (‖y‖ + 1)) * (‖y‖ + 1) = r / 2 := by
      field_simp
    linarith
  set δ : ℝ := r / (4 * (n + 1)) with hδdef
  have hδ : 0 < δ := by positivity
  -- an approximate solver for `H - e i`
  have step : ∀ v : F, ∃ x : D, ‖(H x - lam • (x : F)) - v‖ < δ := by
    intro v
    obtain ⟨z, hz1, x, hx⟩ := (Metric.dense_iff.mp hdense) v δ hδ
    have hx' : H x - lam • (x : F) = z := hx
    exact ⟨x, by rw [hx']; simpa [dist_eq_norm] using hz1⟩
  choose pick hpick using step
  -- the residual sequence and the Neumann partial sums
  set rr : ℕ → F := fun k => Nat.rec y (fun _ p => -(B (pick p))) k with hrrdef
  have hrr0 : rr 0 = y := rfl
  have hrrs : ∀ k, rr (k + 1) = -(B (pick (rr k))) := fun _ => rfl
  set v : ℕ → D := fun k => pick (rr k) with hvdef
  set S : ℕ → D := fun m => ∑ k ∈ Finset.range m, v k with hSdef
  have hvnorm : ∀ k, ‖(v k : F)‖ ≤ (‖rr k‖ + δ) / |e| := by
    intro k
    have h1 : ‖(H (v k) - lam • (v k : F)) - rr k‖ < δ := hpick (rr k)
    have h2 : |e| * ‖(v k : F)‖ ≤ ‖H (v k) - lam • (v k : F)‖ := hlow (v k)
    have h3 : ‖H (v k) - lam • (v k : F)‖ ≤ ‖rr k‖ + δ := by
      have : H (v k) - lam • (v k : F)
          = ((H (v k) - lam • (v k : F)) - rr k) + rr k := by abel
      rw [this]
      calc ‖((H (v k) - lam • (v k : F)) - rr k) + rr k‖
          ≤ ‖(H (v k) - lam • (v k : F)) - rr k‖ + ‖rr k‖ := norm_add_le _ _
        _ ≤ δ + ‖rr k‖ := by linarith
        _ = ‖rr k‖ + δ := by ring
    rw [le_div_iff₀ he0]
    calc ‖(v k : F)‖ * |e| = |e| * ‖(v k : F)‖ := by ring
      _ ≤ ‖H (v k) - lam • (v k : F)‖ := h2
      _ ≤ ‖rr k‖ + δ := h3
  have hrrbound : ∀ k, ‖rr k‖ ≤ q ^ k * ‖y‖ + k * δ := by
    intro k
    induction k with
    | zero => simp [hrr0]
    | succ k ih =>
      have h1 : ‖rr (k + 1)‖ ≤ ‖B‖ * ‖(v k : F)‖ := by
        rw [hrrs k, norm_neg]
        exact B.le_opNorm _
      have h2 : ‖B‖ * ‖(v k : F)‖ ≤ ‖B‖ * ((‖rr k‖ + δ) / |e|) := by
        exact mul_le_mul_of_nonneg_left (hvnorm k) (norm_nonneg B)
      have h3 : ‖B‖ * ((‖rr k‖ + δ) / |e|) = q * (‖rr k‖ + δ) := by
        rw [hqdef]; field_simp
      have h4 : q * (‖rr k‖ + δ) ≤ q * (q ^ k * ‖y‖ + k * δ + δ) := by
        have := ih
        nlinarith
      have h5 : q * (q ^ k * ‖y‖ + k * δ + δ) ≤ q ^ (k + 1) * ‖y‖ + (k + 1) * δ := by
        have hqk : 0 ≤ q ^ k := pow_nonneg hq0 k
        have hy : 0 ≤ ‖y‖ := norm_nonneg y
        have hkd : 0 ≤ (k : ℝ) * δ := by positivity
        have : q * (q ^ k * ‖y‖) = q ^ (k + 1) * ‖y‖ := by ring
        nlinarith [hq1.le, hδ.le]
      push_cast
      push_cast at h4 h5
      linarith
  have hmain : ∀ m : ℕ,
      ‖(H (S m) + B (S m) - lam • (S m : F)) - (y - rr m)‖ ≤ m * δ := by
    intro m
    induction m with
    | zero => simp [hSdef, hrr0]
    | succ m ih =>
      have hSsucc : S (m + 1) = S m + v m := by
        simp [hSdef, Finset.sum_range_succ]
      have hcoe : ((S (m + 1) : D) : F) = (S m : F) + (v m : F) := by
        rw [hSsucc]; rfl
      have hdiff : (H (S (m + 1)) + B (S (m + 1)) - lam • ((S (m + 1) : D) : F))
            - (y - rr (m + 1))
          = ((H (S m) + B (S m) - lam • (S m : F)) - (y - rr m))
            + ((H (v m) - lam • (v m : F)) - rr m) := by
        simp only [hSsucc, hrrs m, map_add, Submodule.coe_add]
        module
      rw [hdiff]
      calc ‖((H (S m) + B (S m) - lam • (S m : F)) - (y - rr m))
              + ((H (v m) - lam • (v m : F)) - rr m)‖
          ≤ ‖(H (S m) + B (S m) - lam • (S m : F)) - (y - rr m)‖
            + ‖(H (v m) - lam • (v m : F)) - rr m‖ := norm_add_le _ _
        _ ≤ m * δ + δ := by
            have := hpick (rr m)
            simp only [hvdef]
            linarith [ih]
        _ = (m + 1 : ℕ) * δ := by push_cast; ring
  refine ⟨H (S n) + B (S n) - lam • (S n : F), ?_, ⟨S n, rfl⟩⟩
  rw [Metric.mem_ball, dist_eq_norm]
  have hsplit : (H (S n) + B (S n) - lam • (S n : F)) - y
      = ((H (S n) + B (S n) - lam • (S n : F)) - (y - rr n)) - rr n := by abel
  have hfin : 2 * (n : ℝ) * δ ≤ r / 2 := by
    have heq : 2 * ((n : ℝ) + 1) * δ = r / 2 := by
      rw [hδdef]; field_simp; ring
    nlinarith [hδ.le, (Nat.cast_nonneg n : (0 : ℝ) ≤ n)]
  calc ‖(H (S n) + B (S n) - lam • (S n : F)) - y‖
      = ‖((H (S n) + B (S n) - lam • (S n : F)) - (y - rr n)) - rr n‖ := by rw [hsplit]
    _ ≤ ‖(H (S n) + B (S n) - lam • (S n : F)) - (y - rr n)‖ + ‖rr n‖ := norm_sub_le _ _
    _ ≤ n * δ + (q ^ n * ‖y‖ + n * δ) := add_le_add (hmain n) (hrrbound n)
    _ < r := by linarith

/-- **Kato–Rellich for bounded perturbations.**  If `H` is symmetric and essentially
self-adjoint on `D`, and `B` is a bounded symmetric operator defined on the whole space,
then `H + B` is essentially self-adjoint on `D`. -/
theorem essentiallySelfAdjointOn_add_bounded [CompleteSpace F] (H : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (B : F →L[ℂ] F)
    (hB : ∀ x y : F, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y)) :
    EssentiallySelfAdjointOn D (H + (B.toLinearMap ∘ₗ D.subtype)) := by
  set K : D →ₗ[ℂ] F := H + (B.toLinearMap ∘ₗ D.subtype) with hK
  have hKapply : ∀ x : D, K x = H x + B (x : F) := fun x => rfl
  have hKsymm : SymmetricOn D K := by
    intro x y
    simp only [hKapply, inner_add_left, inner_add_right, hH x y, hB (x : F) (y : F)]
  -- `H` has trivial deficiency spaces at every non-real point
  have hHall : ∀ σ : ℂ, σ.im ≠ 0 → DeficiencyTrivialAt D H σ := by
    intro σ hσ
    refine deficiencyTrivialAt_of_dense_range H hH 1 one_ne_zero σ hσ ?_ ?_
    · have := dense_range_of_deficiencyTrivialAt H ((1 : ℝ) * Complex.I) (by simpa using hesa.2)
      simpa using this
    · simpa using hesa.1
  -- pick `e` with `|e| > ‖B‖`
  set e : ℝ := ‖B‖ + 1 with hedef
  have he : ‖B‖ < |e| := by
    rw [hedef, abs_of_nonneg (by positivity)]
    linarith
  have he0 : e ≠ 0 := by
    have : (0 : ℝ) < e := by rw [hedef]; positivity
    exact ne_of_gt this
  -- density of the ranges of `K ∓ e i`
  have hdenseH : ∀ d : ℝ, d ≠ 0 →
      Dense (Set.range fun x : D => H x - ((d : ℂ) * Complex.I) • (x : F)) := by
    intro d hd
    refine dense_range_of_deficiencyTrivialAt H ((d : ℂ) * Complex.I) (hHall _ ?_)
    simp [hd]
  have hdenseK : ∀ d : ℝ, ‖B‖ < |d| →
      Dense (Set.range fun x : D => (H x + B (x : F)) - ((d : ℂ) * Complex.I) • (x : F)) := by
    intro d hd
    have hd0 : d ≠ 0 := by
      intro h
      rw [h] at hd
      simp at hd
      linarith [norm_nonneg B]
    exact dense_range_add_bounded H hH B d hd (hdenseH d hd0)
  have habs : ‖B‖ < |(-e)| := by rwa [abs_neg]
  have hdefK : DeficiencyTrivialAt D K ((e : ℂ) * Complex.I) := by
    refine deficiencyTrivialAt_of_dense K _ ?_
    have hconj : (starRingEnd ℂ) ((e : ℂ) * Complex.I) = ((-e : ℝ) : ℂ) * Complex.I := by
      push_cast
      simp [mul_comm]
    rw [hconj]
    simpa [hKapply] using hdenseK (-e) habs
  have hdenseKe : Dense (Set.range fun x : D => K x - ((e : ℂ) * Complex.I) • (x : F)) := by
    simpa [hKapply] using hdenseK e he
  exact ⟨deficiencyTrivialAt_of_dense_range K hKsymm e he0 Complex.I (by simp) hdenseKe hdefK,
    deficiencyTrivialAt_of_dense_range K hKsymm e he0 (-Complex.I) (by simp) hdenseKe hdefK⟩

end BookProof.KatoRellich
