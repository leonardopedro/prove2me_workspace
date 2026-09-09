import Mathlib
import BookProof.ChapterKatoRellichDeficiency

/-!
# Kato–Rellich for **relatively bounded** perturbations

`BookProof.ChapterKatoRellichDeficiency` proves the Kato–Rellich theorem for a
*bounded* symmetric perturbation.  This module proves the genuine version, the
one the Navier–Stokes Lagrangian route needs: the perturbation may be
**unbounded**, and is only assumed to be dominated by the unperturbed operator,

`‖B x‖ ≤ a ‖H x‖ + b ‖x‖`,  `0 ≤ a < 1`,

on the common domain `D`.  The conclusion is unchanged: if `H` is symmetric and
essentially self-adjoint on `D` and `B` is symmetric on `D`, then `H + B` is
essentially self-adjoint on `D`.

The proof is the same explicit Neumann iteration as in the bounded case — no
closures, no spectral theorem — with one new ingredient
(`norm_le_of_relBound`): for symmetric `H`,

`‖H x - e i x‖² = ‖H x‖² + e²‖x‖²`,

so `‖H x‖ ≤ ‖H x - e i x‖` **and** `|e| ‖x‖ ≤ ‖H x - e i x‖`, whence

`‖B x‖ ≤ (a + b/|e|) ‖H x - e i x‖`.

Choosing the shift `|e|` large makes the contraction factor `q = a + b/|e|`
smaller than `1`, which is exactly the room the hypothesis `a < 1` buys.  This
is the point where the relative bound replaces the operator norm `‖B‖` of the
bounded case; everything downstream is the same geometric Neumann estimate.

## What is proved

* `norm_le_of_relBound` — the relative bound transferred to the shifted
  operator, with contraction factor `a + b/|e|`;
* `dense_range_add_relBounded` — the Neumann step: at a shift with
  `a + b/|e| < 1` the range of `H + B - e i` is dense as soon as the range of
  `H - e i` is;
* `essentiallySelfAdjointOn_add_relBounded` — **the Kato–Rellich theorem**;
* `symmetricOn_add` — symmetry of the sum, and
  `essentiallySelfAdjointOn_add_bounded'` — the bounded case recovered as the
  special case `a = 0`, `b = ‖B‖`.
-/

namespace BookProof.KatoRellich

open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- The sum of two operators symmetric on `D` is symmetric on `D`. -/
theorem symmetricOn_add {H B : D →ₗ[ℂ] F} (hH : SymmetricOn D H) (hB : SymmetricOn D B) :
    SymmetricOn D (H + B) := by
  intro x y
  simp only [LinearMap.add_apply, inner_add_left, inner_add_right, hH x y, hB x y]

/-- **The relative bound at a non-real shift.**  For a symmetric `H` the shifted
operator `H - e i` dominates both `H` and `|e|` times the identity, so a
relative bound `‖B x‖ ≤ a‖H x‖ + b‖x‖` becomes a *contraction* bound with factor
`a + b/|e|` against `H - e i`. -/
theorem norm_le_of_relBound (H B : D →ₗ[ℂ] F) (hH : SymmetricOn D H) {a b e : ℝ}
    (ha : 0 ≤ a) (hb : 0 ≤ b) (he : e ≠ 0)
    (hrel : ∀ x : D, ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖) (x : D) :
    ‖B x‖ ≤ (a + b / |e|) * ‖H x - ((e : ℂ) * Complex.I) • (x : F)‖ := by
  have he0 : (0 : ℝ) < |e| := abs_pos.mpr he
  set N : ℝ := ‖H x - ((e : ℂ) * Complex.I) • (x : F)‖ with hN
  have hsq : N ^ 2 = ‖H x‖ ^ 2 + e ^ 2 * ‖(x : F)‖ ^ 2 := norm_sub_smul_sq H hH e x
  have hN0 : 0 ≤ N := norm_nonneg _
  have h1 : ‖H x‖ ≤ N := by
    nlinarith [norm_nonneg (H x), sq_nonneg (e * ‖(x : F)‖), norm_nonneg (x : F),
      sq_nonneg ‖(x : F)‖]
  have h2 : |e| * ‖(x : F)‖ ≤ N := by
    nlinarith [norm_nonneg (H x), norm_nonneg (x : F), sq_abs e,
      mul_nonneg (abs_nonneg e) (norm_nonneg (x : F))]
  have h3 : b * ‖(x : F)‖ ≤ (b / |e|) * N := by
    rw [div_mul_eq_mul_div, le_div_iff₀ he0]
    nlinarith
  calc ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖ := hrel x
    _ ≤ a * N + (b / |e|) * N := by nlinarith
    _ = (a + b / |e|) * N := by ring

/-- **The Neumann step for a relatively bounded perturbation.**  If the range of
`H - e i` is dense and `B` is symmetric on `D` with `‖B x‖ ≤ a‖H x‖ + b‖x‖` and
contraction factor `q = a + b/|e| < 1`, then the range of `H + B - e i` is dense
as well.  Every approximant is a *finite* sum of domain vectors, so no closure of
`H` is involved. -/
theorem dense_range_add_relBounded (H B : D →ₗ[ℂ] F) (hH : SymmetricOn D H) {a b e : ℝ}
    (ha : 0 ≤ a) (hb : 0 ≤ b) (he : e ≠ 0)
    (hrel : ∀ x : D, ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖) (hq1 : a + b / |e| < 1)
    (hdense : Dense (Set.range fun x : D => H x - ((e : ℂ) * Complex.I) • (x : F))) :
    Dense (Set.range fun x : D => (H x + B x) - ((e : ℂ) * Complex.I) • (x : F)) := by
  have he0 : (0 : ℝ) < |e| := abs_pos.mpr he
  set lam : ℂ := (e : ℂ) * Complex.I with hlam
  set q : ℝ := a + b / |e| with hqdef
  have hq0 : 0 ≤ q := by positivity
  have hBq : ∀ x : D, ‖B x‖ ≤ q * ‖H x - lam • (x : F)‖ :=
    norm_le_of_relBound H B hH ha hb he hrel
  rw [Metric.dense_iff]
  intro y r hr
  obtain ⟨n, hn0⟩ : ∃ n : ℕ, q ^ n < (r / 2) / (‖y‖ + 1) :=
    exists_pow_lt_of_lt_one (by positivity) hq1
  have hn : q ^ n * ‖y‖ < r / 2 := by
    have h1 : q ^ n * ‖y‖ ≤ q ^ n * (‖y‖ + 1) := by
      have := pow_nonneg hq0 n
      nlinarith [norm_nonneg y]
    have h2 : q ^ n * (‖y‖ + 1) < ((r / 2) / (‖y‖ + 1)) * (‖y‖ + 1) := by
      have : (0 : ℝ) < ‖y‖ + 1 := by positivity
      exact mul_lt_mul_of_pos_right hn0 this
    have h3 : ((r / 2) / (‖y‖ + 1)) * (‖y‖ + 1) = r / 2 := by field_simp
    linarith
  set δ : ℝ := r / (4 * (n + 1)) with hδdef
  have hδ : 0 < δ := by positivity
  have step : ∀ v : F, ∃ x : D, ‖(H x - lam • (x : F)) - v‖ < δ := by
    intro v
    obtain ⟨z, hz1, x, hx⟩ := (Metric.dense_iff.mp hdense) v δ hδ
    have hx' : H x - lam • (x : F) = z := hx
    exact ⟨x, by rw [hx']; simpa [dist_eq_norm] using hz1⟩
  choose pick hpick using step
  set rr : ℕ → F := fun k => Nat.rec y (fun _ p => -(B (pick p))) k with hrrdef
  have hrr0 : rr 0 = y := rfl
  have hrrs : ∀ k, rr (k + 1) = -(B (pick (rr k))) := fun _ => rfl
  set v : ℕ → D := fun k => pick (rr k) with hvdef
  set S : ℕ → D := fun m => ∑ k ∈ Finset.range m, v k with hSdef
  have hrrbound : ∀ k, ‖rr k‖ ≤ q ^ k * ‖y‖ + k * δ := by
    intro k
    induction k with
    | zero => simp [hrr0]
    | succ k ih =>
      have h1 : ‖rr (k + 1)‖ ≤ q * ‖H (v k) - lam • (v k : F)‖ := by
        rw [hrrs k, norm_neg]
        exact hBq (v k)
      have hstep : ‖(H (v k) - lam • (v k : F)) - rr k‖ < δ := hpick (rr k)
      have h3 : ‖H (v k) - lam • (v k : F)‖ ≤ ‖rr k‖ + δ := by
        have heq : H (v k) - lam • (v k : F)
            = ((H (v k) - lam • (v k : F)) - rr k) + rr k := by abel
        rw [heq]
        calc ‖((H (v k) - lam • (v k : F)) - rr k) + rr k‖
            ≤ ‖(H (v k) - lam • (v k : F)) - rr k‖ + ‖rr k‖ := norm_add_le _ _
          _ ≤ δ + ‖rr k‖ := by linarith
          _ = ‖rr k‖ + δ := by ring
      have h4 : q * ‖H (v k) - lam • (v k : F)‖ ≤ q * (‖rr k‖ + δ) :=
        mul_le_mul_of_nonneg_left h3 hq0
      have h5 : q * (‖rr k‖ + δ) ≤ q * (q ^ k * ‖y‖ + k * δ + δ) := by nlinarith
      have h6 : q * (q ^ k * ‖y‖ + k * δ + δ) ≤ q ^ (k + 1) * ‖y‖ + (k + 1) * δ := by
        have hqk : 0 ≤ q ^ k := pow_nonneg hq0 k
        have hy : 0 ≤ ‖y‖ := norm_nonneg y
        have hkd : 0 ≤ (k : ℝ) * δ := by positivity
        have hmul : q * (q ^ k * ‖y‖) = q ^ (k + 1) * ‖y‖ := by ring
        nlinarith [hq1.le, hδ.le]
      push_cast
      push_cast at h5 h6
      linarith
  have hmain : ∀ m : ℕ,
      ‖(H (S m) + B (S m) - lam • (S m : F)) - (y - rr m)‖ ≤ m * δ := by
    intro m
    induction m with
    | zero => simp [hSdef, hrr0]
    | succ m ih =>
      have hSsucc : S (m + 1) = S m + v m := by
        simp [hSdef, Finset.sum_range_succ]
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

/-- **The Kato–Rellich theorem.**  Let `H` be symmetric and essentially
self-adjoint on the domain `D`, and let `B` be symmetric on the *same* domain and
`H`-bounded with relative bound `a < 1`:

`‖B x‖ ≤ a ‖H x‖ + b ‖x‖`  for all `x ∈ D`.

Then `H + B` is essentially self-adjoint on `D`.  The perturbation `B` may be
unbounded; only the domination by `H` is used. -/
theorem essentiallySelfAdjointOn_add_relBounded [CompleteSpace F] (H B : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (hB : SymmetricOn D B)
    {a b : ℝ} (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hrel : ∀ x : D, ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖) :
    EssentiallySelfAdjointOn D (H + B) := by
  set K : D →ₗ[ℂ] F := H + B with hK
  have hKapply : ∀ x : D, K x = H x + B x := fun x => rfl
  have hKsymm : SymmetricOn D K := symmetricOn_add hH hB
  -- `H` has trivial deficiency spaces at every non-real point
  have hHall : ∀ σ : ℂ, σ.im ≠ 0 → DeficiencyTrivialAt D H σ := by
    intro σ hσ
    refine deficiencyTrivialAt_of_dense_range H hH 1 one_ne_zero σ hσ ?_ ?_
    · have := dense_range_of_deficiencyTrivialAt H ((1 : ℝ) * Complex.I) (by simpa using hesa.2)
      simpa using this
    · simpa using hesa.1
  -- a shift large enough to make the contraction factor `< 1`
  set e : ℝ := (b + 1) / (1 - a) with hedef
  have h1a : (0 : ℝ) < 1 - a := by linarith
  have he0' : (0 : ℝ) < e := by rw [hedef]; positivity
  have he0 : e ≠ 0 := ne_of_gt he0'
  have habse : |e| = e := abs_of_pos he0'
  have hqlt : ∀ d : ℝ, e ≤ |d| → a + b / |d| < 1 := by
    intro d hd
    have hd0 : (0 : ℝ) < |d| := lt_of_lt_of_le he0' hd
    have hbe : b / |d| ≤ b / e := by
      rcases eq_or_lt_of_le hb with h | h
      · simp [← h]
      · exact div_le_div_of_nonneg_left hb he0' hd
    have hlt : b / e < 1 - a := by
      rw [hedef, div_div_eq_mul_div, div_lt_iff₀ (by positivity)]
      nlinarith
    linarith
  have hdenseH : ∀ d : ℝ, d ≠ 0 →
      Dense (Set.range fun x : D => H x - ((d : ℂ) * Complex.I) • (x : F)) := by
    intro d hd
    refine dense_range_of_deficiencyTrivialAt H ((d : ℂ) * Complex.I) (hHall _ ?_)
    simp [hd]
  have hdenseK : ∀ d : ℝ, e ≤ |d| →
      Dense (Set.range fun x : D => (H x + B x) - ((d : ℂ) * Complex.I) • (x : F)) := by
    intro d hd
    have hd0 : d ≠ 0 := by
      intro h
      rw [h] at hd
      simp at hd
      linarith
    exact dense_range_add_relBounded H B hH ha hb hd0 hrel (hqlt d hd) (hdenseH d hd0)
  have hself : e ≤ |e| := le_of_eq habse.symm
  have hneg : e ≤ |(-e)| := by rw [abs_neg]; exact hself
  have hdefK : DeficiencyTrivialAt D K ((e : ℂ) * Complex.I) := by
    refine deficiencyTrivialAt_of_dense K _ ?_
    have hconj : (starRingEnd ℂ) ((e : ℂ) * Complex.I) = ((-e : ℝ) : ℂ) * Complex.I := by
      push_cast
      simp [mul_comm]
    rw [hconj]
    simpa [hKapply] using hdenseK (-e) hneg
  have hdenseKe : Dense (Set.range fun x : D => K x - ((e : ℂ) * Complex.I) • (x : F)) := by
    simpa [hKapply] using hdenseK e hself
  exact ⟨deficiencyTrivialAt_of_dense_range K hKsymm e he0 Complex.I (by simp) hdenseKe hdefK,
    deficiencyTrivialAt_of_dense_range K hKsymm e he0 (-Complex.I) (by simp) hdenseKe hdefK⟩

/-- The bounded case is the special case `a = 0`, `b = ‖B‖` of the relative
theorem — a consistency check against
`BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded`. -/
theorem essentiallySelfAdjointOn_add_bounded' [CompleteSpace F] (H : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (B : F →L[ℂ] F)
    (hB : ∀ x y : F, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y)) :
    EssentiallySelfAdjointOn D (H + (B.toLinearMap ∘ₗ D.subtype)) :=
  essentiallySelfAdjointOn_add_relBounded H _ hH hesa
    (fun x y => hB (x : F) (y : F)) le_rfl one_pos (norm_nonneg B)
    (fun x => by simpa using B.le_opNorm (x : F))

end BookProof.KatoRellich
