import Mathlib

/-!
# Chapter KrylovShiftSpan — the multi-shift Krylov spaces

The SIRK/Hashimoto solver builds its subspace either from the **shifted products**
`v, (H − z₀)v, (H − z₁)(H − z₀)v, …` or from the **resolvent (rational Krylov)**
sequence `v, X₀v, X₁X₀v, …` with `Xᵢ = (H − zᵢ)⁻¹`, for a sequence of (possibly
distinct, possibly complex) shifts, while the theory is written for the plain Krylov
space `span{v, Hv, …, Hᵏv}`.

This chapter proves that all three descriptions agree, in the algebraic generality in
which they are true: no topology, no self-adjointness, an arbitrary module over an
arbitrary commutative ring, and an arbitrary shift sequence.

### Relation to the rest of the development

The *forward-sequence* half of the statement is already available analytically in
`BookProof/ChapterSirkMultiShift.lean` (`krylov_multiShift_eq_standard`,
`krylov_multiShift_span_eq_of_shifts`), over a field and for vectors of the sequence;
what is re-proved here is its purely algebraic operator-product form
(`forwardProd`, over a commutative ring), because the resolvent statement below needs
the products themselves, not just the vectors they produce.  The *resolvent* half is
new: `BookProof/ChapterHashimotoComplexShifts.lean` describes the rational Krylov space
as rational functions of one fixed resolvent (`sirkDen_rkVec`), whereas
`resolventSpan_eq_map_krylovSpan` below identifies it with the image of the ordinary
Krylov space of `H` itself under the product of the resolvents.

## Deliverables

* `shiftOp T z = T − z`, `forwardProd T z j = (T − z_{j−1}) ⋯ (T − z₀)` and
  `krylovSpan` / `forwardSpan` — the plain and the shifted Krylov subspaces.
* **`forwardSpan_eq_krylovSpan`** — the two spans coincide at every truncation level `k`:
  the shifted forward sequence spans exactly the Krylov space.  Hence
  `forwardSpan_eq_forwardSpan` : *the span does not depend on the shifts at all*, which is
  what makes the numerics' freedom to choose (and to reorder, or to repeat) the shifts
  harmless.
* `resProd X j = X_{j−1} ⋯ X₀` and `resolventSpan`; `commute_resolvent_shiftOp` and
  `resProd_mul_tailProd` — the resolvent of one shift commutes with every shifted
  operator, and the resolvents telescope against the shifted products.
* **`resolventSpan_eq_map_krylovSpan`** — the rational (resolvent) Krylov space is the
  image of the ordinary Krylov space under the product of all `k` resolvents:
  `span{v, X₀v, X₁X₀v, …, X_{k−1}⋯X₀v} = (X_{k−1}⋯X₀) '' span{v, Tv, …, Tᵏv}`.
  So the three subspaces the plan lists are the same subspace up to the invertible factor
  `X_{k−1}⋯X₀`.  (No permutation statement is claimed; what is proved is the description
  above, which is the form the compression arguments use.)  The bridge is
  `tailSpan_eq_krylovSpan`: the tail products `(T − z_{k−1}) ⋯ (T − z_j)`, `j ≤ k`, are
  the forward products of the *reversed* shift sequence, hence span the Krylov space too.
* `resProd_mul_forwardProd` / `forwardProd_mul_resProd` (the two products are mutually
  inverse) and hence `krylovSpan_eq_map_resolventSpan`, the inverse form of the identity
  above.
* `resVec` and `resolventSpan_eq_span_resVec` — the resolvent span written with the
  vectors the solver actually computes, `v, X₀v, X₁X₀v, …`, one resolvent solve at a time.
* **`resolventSpan_of_perm`** — *the rational Krylov space does not depend on the order in
  which the shifts are used*: for a permutation of `ℕ` fixing everything from `k` on,
  the reordered schedule reaches the same subspace (`resProd_of_perm`: the product of the
  resolvents is order-independent, since they commute).  The intermediate flag does
  change; the space at level `k` does not.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.KrylovShiftSpan

variable {R : Type*} [CommRing R] {V : Type*} [AddCommGroup V] [Module R V]

/-! ## 1. The shifted operators and the two spans -/

/-- The shifted operator `T − z`. -/
def shiftOp (T : Module.End R V) (z : R) : Module.End R V := T - z • (1 : Module.End R V)

/-- The forward product `(T − z_{j−1}) ⋯ (T − z₀)` of the first `j` shifted operators. -/
def forwardProd (T : Module.End R V) (z : ℕ → R) : ℕ → Module.End R V
  | 0 => 1
  | (n + 1) => shiftOp T (z n) * forwardProd T z n

@[simp] theorem forwardProd_zero (T : Module.End R V) (z : ℕ → R) :
    forwardProd T z 0 = 1 := rfl

theorem forwardProd_succ (T : Module.End R V) (z : ℕ → R) (n : ℕ) :
    forwardProd T z (n + 1) = shiftOp T (z n) * forwardProd T z n := rfl

/-- The **Krylov subspace** `span{v, Tv, …, Tᵏv}`. -/
def krylovSpan (T : Module.End R V) (v : V) (k : ℕ) : Submodule R V :=
  Submodule.span R {x | ∃ j ≤ k, x = (T ^ j) v}

/-- The **shifted (forward) Krylov subspace** `span{v, (T − z₀)v, (T − z₁)(T − z₀)v, …}`. -/
def forwardSpan (T : Module.End R V) (z : ℕ → R) (v : V) (k : ℕ) : Submodule R V :=
  Submodule.span R {x | ∃ j ≤ k, x = forwardProd T z j v}

theorem pow_mem_krylovSpan {T : Module.End R V} {v : V} {j k : ℕ} (hjk : j ≤ k) :
    (T ^ j) v ∈ krylovSpan T v k :=
  Submodule.subset_span ⟨j, hjk, rfl⟩

theorem forwardProd_mem_forwardSpan {T : Module.End R V} {z : ℕ → R} {v : V} {j k : ℕ}
    (hjk : j ≤ k) : forwardProd T z j v ∈ forwardSpan T z v k :=
  Submodule.subset_span ⟨j, hjk, rfl⟩

theorem krylovSpan_mono {T : Module.End R V} {v : V} {k l : ℕ} (hkl : k ≤ l) :
    krylovSpan T v k ≤ krylovSpan T v l :=
  Submodule.span_mono fun _ ⟨j, hj, hx⟩ => ⟨j, hj.trans hkl, hx⟩

theorem forwardSpan_mono {T : Module.End R V} {z : ℕ → R} {v : V} {k l : ℕ} (hkl : k ≤ l) :
    forwardSpan T z v k ≤ forwardSpan T z v l :=
  Submodule.span_mono fun _ ⟨j, hj, hx⟩ => ⟨j, hj.trans hkl, hx⟩

/-- Applying `T` moves the Krylov space one level up. -/
theorem map_krylovSpan_le (T : Module.End R V) (v : V) (k : ℕ) :
    Submodule.map T (krylovSpan T v k) ≤ krylovSpan T v (k + 1) := by
  rw [krylovSpan, Submodule.map_span, Submodule.span_le]
  rintro x ⟨y, ⟨j, hj, rfl⟩, rfl⟩
  have : T ((T ^ j) v) = (T ^ (j + 1)) v := by
    rw [pow_succ']
    rfl
  rw [this]
  exact pow_mem_krylovSpan (by omega)

/-- Applying `T` moves the shifted Krylov space one level up. -/
theorem map_forwardSpan_le (T : Module.End R V) (z : ℕ → R) (v : V) (k : ℕ) :
    Submodule.map T (forwardSpan T z v k) ≤ forwardSpan T z v (k + 1) := by
  rw [forwardSpan, Submodule.map_span, Submodule.span_le]
  rintro x ⟨y, ⟨j, hj, rfl⟩, rfl⟩
  have hstep : T (forwardProd T z j v)
      = forwardProd T z (j + 1) v + z j • forwardProd T z j v := by
    rw [forwardProd_succ, shiftOp]
    simp [Module.End.mul_apply]
  rw [hstep]
  refine Submodule.add_mem _ ?_ (Submodule.smul_mem _ _ ?_)
  · exact forwardProd_mem_forwardSpan (by omega)
  · exact forwardProd_mem_forwardSpan (by omega)

theorem forwardProd_mem_krylovSpan (T : Module.End R V) (z : ℕ → R) (v : V) :
    ∀ j : ℕ, forwardProd T z j v ∈ krylovSpan T v j := by
  intro j
  induction j with
  | zero =>
    have : forwardProd T z 0 v = (T ^ 0) v := by simp
    rw [this]
    exact pow_mem_krylovSpan le_rfl
  | succ n ih =>
    have hstep : forwardProd T z (n + 1) v
        = T (forwardProd T z n v) - z n • forwardProd T z n v := by
      rw [forwardProd_succ, shiftOp]
      simp [Module.End.mul_apply]
    rw [hstep]
    refine Submodule.sub_mem _ ?_ (Submodule.smul_mem _ _ ?_)
    · exact map_krylovSpan_le T v n ⟨_, ih, rfl⟩
    · exact krylovSpan_mono (by omega) ih

theorem pow_mem_forwardSpan (T : Module.End R V) (z : ℕ → R) (v : V) :
    ∀ j : ℕ, (T ^ j) v ∈ forwardSpan T z v j := by
  intro j
  induction j with
  | zero =>
    have : (T ^ 0) v = forwardProd T z 0 v := by simp
    rw [this]
    exact forwardProd_mem_forwardSpan le_rfl
  | succ n ih =>
    have : (T ^ (n + 1)) v = T ((T ^ n) v) := by
      rw [pow_succ']
      rfl
    rw [this]
    exact map_forwardSpan_le T z v n ⟨_, ih, rfl⟩

/-- **The shifted forward sequence spans exactly the Krylov space**, for an arbitrary
sequence of shifts. -/
theorem forwardSpan_eq_krylovSpan (T : Module.End R V) (z : ℕ → R) (v : V) (k : ℕ) :
    forwardSpan T z v k = krylovSpan T v k := by
  refine le_antisymm ?_ ?_
  · rw [forwardSpan, Submodule.span_le]
    rintro x ⟨j, hj, rfl⟩
    exact krylovSpan_mono hj (forwardProd_mem_krylovSpan T z v j)
  · rw [krylovSpan, Submodule.span_le]
    rintro x ⟨j, hj, rfl⟩
    exact forwardSpan_mono hj (pow_mem_forwardSpan T z v j)

/-- **The shifted Krylov space does not depend on the shifts**: any two shift sequences
give the same subspace. -/
theorem forwardSpan_eq_forwardSpan (T : Module.End R V) (z z' : ℕ → R) (v : V) (k : ℕ) :
    forwardSpan T z v k = forwardSpan T z' v k := by
  rw [forwardSpan_eq_krylovSpan, forwardSpan_eq_krylovSpan]

/-! ## 2. The resolvent (rational Krylov) side -/

section Resolvent

variable (T : Module.End R V) (z : ℕ → R) (X : ℕ → Module.End R V)

/-- The hypothesis that `X i` is a two-sided inverse of the shifted operator `T − z i`,
i.e. `X i` is the resolvent at the shift `z i`. -/
def IsResolventFamily : Prop :=
  ∀ i, X i * shiftOp T (z i) = 1 ∧ shiftOp T (z i) * X i = 1

/-- The product `X_{j−1} ⋯ X₀` of the first `j` resolvents. -/
def resProd (X : ℕ → Module.End R V) : ℕ → Module.End R V
  | 0 => 1
  | (n + 1) => X n * resProd X n

@[simp] theorem resProd_zero : resProd X 0 = 1 := rfl

theorem resProd_succ (n : ℕ) : resProd X (n + 1) = X n * resProd X n := rfl

/-- The **rational (resolvent) Krylov subspace** `span{v, X₀v, X₁X₀v, …}`. -/
def resolventSpan (X : ℕ → Module.End R V) (v : V) (k : ℕ) : Submodule R V :=
  Submodule.span R {x | ∃ j ≤ k, x = resProd X j v}

variable {T z X}

/-- Any two shifted operators commute (they are polynomials in `T`). -/
theorem commute_shiftOp (a b : R) : Commute (shiftOp T a) (shiftOp T b) := by
  simp only [shiftOp, Commute, SemiconjBy, sub_mul, mul_sub, smul_mul_assoc,
    mul_smul_comm, one_mul, mul_one, smul_sub, smul_smul, mul_comm a b]
  abel

/-- A resolvent commutes with every shifted operator. -/
theorem commute_resolvent_shiftOp (hX : IsResolventFamily T z X) (i : ℕ) (b : R) :
    Commute (X i) (shiftOp T b) := by
  have hc : Commute (shiftOp T (z i)) (shiftOp T b) := commute_shiftOp (z i) b
  have h1 := (hX i).1
  have h2 := (hX i).2
  have : X i * shiftOp T b = X i * shiftOp T b * (shiftOp T (z i) * X i) := by
    rw [h2, mul_one]
  calc X i * shiftOp T b
      = X i * shiftOp T b * (shiftOp T (z i) * X i) := this
    _ = X i * (shiftOp T b * shiftOp T (z i)) * X i := by
        simp only [mul_assoc]
    _ = X i * (shiftOp T (z i) * shiftOp T b) * X i := by rw [hc.eq]
    _ = (X i * shiftOp T (z i)) * (shiftOp T b * X i) := by
        simp only [mul_assoc]
    _ = shiftOp T b * X i := by rw [h1, one_mul]

/-- Two resolvents commute. -/
theorem commute_resolvent (hX : IsResolventFamily T z X) (i j : ℕ) :
    Commute (X i) (X j) := by
  have h1 := (hX j).1
  have h2 := (hX j).2
  have hc : Commute (X i) (shiftOp T (z j)) := commute_resolvent_shiftOp hX i (z j)
  have : X i * X j = (X j * shiftOp T (z j)) * X i * X j := by rw [h1, one_mul]
  calc X i * X j
      = (X j * shiftOp T (z j)) * X i * X j := this
    _ = X j * (shiftOp T (z j) * X i) * X j := by simp only [mul_assoc]
    _ = X j * (X i * shiftOp T (z j)) * X j := by rw [hc.eq]
    _ = X j * X i * (shiftOp T (z j) * X j) := by simp only [mul_assoc]
    _ = X j * X i := by rw [h2, mul_one]

/-- A resolvent commutes with every forward product. -/
theorem commute_resolvent_forwardProd (hX : IsResolventFamily T z X) (i j : ℕ) :
    Commute (X i) (forwardProd T z j) := by
  induction j with
  | zero => simp [forwardProd]
  | succ n ih =>
    rw [forwardProd_succ]
    exact (commute_resolvent_shiftOp hX i (z n)).mul_right ih

/-- A product of `k` resolvents commutes with every shifted operator. -/
theorem commute_resProd_shiftOp (hX : IsResolventFamily T z X) (b : R) :
    ∀ n, Commute (resProd X n) (shiftOp T b) := by
  intro n
  induction n with
  | zero => simp [resProd]
  | succ m ih =>
    rw [resProd_succ]
    exact Commute.mul_left (commute_resolvent_shiftOp hX m b) ih

/-- The auxiliary product `(T − z_{k−1}) ⋯ (T − z_j)` of the shifts from `j` to `k − 1`. -/
def tailProd (T : Module.End R V) (z : ℕ → R) (j : ℕ) : ℕ → Module.End R V
  | 0 => 1
  | (n + 1) => if j ≤ n then shiftOp T (z n) * tailProd T z j n else tailProd T z j n

/-- An empty tail product is the identity. -/
theorem tailProd_of_le : ∀ {j n : ℕ}, n ≤ j → tailProd T z j n = 1 := by
  intro j n
  induction n with
  | zero => intro _; rfl
  | succ m ih =>
    intro h
    rw [tailProd, if_neg (by omega)]
    exact ih (by omega)

theorem tailProd_self (j : ℕ) : tailProd T z j j = 1 := tailProd_of_le le_rfl

theorem tailProd_succ_of_le {j n : ℕ} (h : j ≤ n) :
    tailProd T z j (n + 1) = shiftOp T (z n) * tailProd T z j n := by
  rw [tailProd, if_pos h]

/-- A tail product commutes with every shifted operator. -/
theorem commute_tailProd_shiftOp (j : ℕ) (b : R) :
    ∀ k, Commute (tailProd T z j k) (shiftOp T b) := by
  intro k
  induction k with
  | zero => simp [tailProd]
  | succ n ih =>
    by_cases h : j ≤ n
    · rw [tailProd_succ_of_le h]
      exact Commute.mul_left (commute_shiftOp (z n) b) ih
    · rw [tailProd, if_neg h]
      exact ih

/-- **Peel the right-most factor off a tail product**: `(T − z_{k−1}) ⋯ (T − z_j)` is
`(T − z_{k−1}) ⋯ (T − z_{j+1})` times `(T − z_j)`. -/
theorem tailProd_peel_right {j : ℕ} :
    ∀ k, j < k → tailProd T z j k = tailProd T z (j + 1) k * shiftOp T (z j) := by
  intro k
  induction k with
  | zero => intro h; exact absurd h (by omega)
  | succ n ih =>
    intro h
    rw [tailProd_succ_of_le (by omega : j ≤ n)]
    rcases Nat.lt_or_ge j n with hjn | hjn
    · rw [ih hjn, tailProd_succ_of_le (by omega : j + 1 ≤ n), mul_assoc]
    · have hj : j = n := by omega
      subst hj
      rw [tailProd_of_le le_rfl, tailProd_of_le (by omega), mul_one, one_mul]

/-- The forward product splits as the tail times the head. -/
theorem forwardProd_eq_tailProd_mul (T : Module.End R V) (z : ℕ → R) {j : ℕ} :
    ∀ k, j ≤ k → forwardProd T z k = tailProd T z j k * forwardProd T z j := by
  intro k
  induction k with
  | zero =>
    intro h
    have hj : j = 0 := Nat.le_zero.mp h
    subst hj
    simp [tailProd_self]
  | succ n ih =>
    intro h
    rcases Nat.lt_or_ge n j with hn | hn
    · have hj : j = n + 1 := by omega
      subst hj
      rw [tailProd_self, one_mul]
    · rw [forwardProd_succ, ih hn, tailProd_succ_of_le hn, mul_assoc]

/-- **`resProd X k` telescopes the tail product away.** -/
theorem resProd_mul_tailProd (hX : IsResolventFamily T z X) {j : ℕ} :
    ∀ k, j ≤ k → resProd X k * tailProd T z j k = resProd X j := by
  intro k
  induction k with
  | zero =>
    intro h
    have hj : j = 0 := Nat.le_zero.mp h
    subst hj
    simp [tailProd_self]
  | succ n ih =>
    intro h
    rcases Nat.lt_or_ge n j with hn | hn
    · have hj : j = n + 1 := by omega
      subst hj
      rw [tailProd_self, mul_one]
    · rw [tailProd_succ_of_le hn, resProd_succ, mul_assoc]
      have hcomm := (commute_resProd_shiftOp hX (z n) n).eq
      calc X n * (resProd X n * (shiftOp T (z n) * tailProd T z j n))
          = X n * ((resProd X n * shiftOp T (z n)) * tailProd T z j n) := by
            simp only [mul_assoc]
        _ = X n * ((shiftOp T (z n) * resProd X n) * tailProd T z j n) := by rw [hcomm]
        _ = (X n * shiftOp T (z n)) * (resProd X n * tailProd T z j n) := by
            simp only [mul_assoc]
        _ = resProd X j := by rw [(hX n).1, one_mul, ih hn]

/-! ## 3. The tail products span the Krylov space again -/

/-- A forward product commutes with every shifted operator. -/
theorem commute_forwardProd_shiftOp (b : R) :
    ∀ n, Commute (forwardProd T z n) (shiftOp T b) := by
  intro n
  induction n with
  | zero => simp [forwardProd]
  | succ m ih =>
    rw [forwardProd_succ]
    exact Commute.mul_left (commute_shiftOp (z m) b) ih

/-- **The tail products are, up to reversing the shift sequence, forward products.**
Concretely `(T − z_{k−1}) ⋯ (T − z_{k−m})` is the `m`-th forward product of the reversed
shift sequence `i ↦ z_{k−1−i}`. -/
theorem tailProd_eq_forwardProd_rev (T : Module.End R V) (z : ℕ → R) (k : ℕ) :
    ∀ m, m ≤ k → tailProd T z (k - m) k = forwardProd T (fun i => z (k - 1 - i)) m := by
  intro m
  induction m with
  | zero => intro _; simpa using tailProd_of_le (le_refl k)
  | succ n ih =>
    intro h
    have hn : n ≤ k := by omega
    have hlt : k - (n + 1) < k := by omega
    have hsucc : k - (n + 1) + 1 = k - n := by omega
    rw [tailProd_peel_right k hlt, hsucc, ih hn, forwardProd_succ]
    have hidx : k - 1 - n = k - (n + 1) := by omega
    rw [hidx]
    exact (commute_forwardProd_shiftOp (T := T) (z := fun i => z (k - 1 - i))
      (z (k - (n + 1))) n).eq

/-- The tail products of a fixed truncation level span exactly the Krylov space. -/
theorem tailSpan_eq_krylovSpan (T : Module.End R V) (z : ℕ → R) (v : V) (k : ℕ) :
    Submodule.span R {x | ∃ j ≤ k, x = tailProd T z j k v} = krylovSpan T v k := by
  have hset : {x : V | ∃ j ≤ k, x = tailProd T z j k v}
      = {x : V | ∃ m ≤ k, x = forwardProd T (fun i => z (k - 1 - i)) m v} := by
    ext x
    constructor
    · rintro ⟨j, hj, rfl⟩
      refine ⟨k - j, by omega, ?_⟩
      have := tailProd_eq_forwardProd_rev T z k (k - j) (by omega)
      rw [show k - (k - j) = j by omega] at this
      rw [this]
    · rintro ⟨m, hm, rfl⟩
      refine ⟨k - m, by omega, ?_⟩
      rw [tailProd_eq_forwardProd_rev T z k m hm]
  rw [hset]
  exact forwardSpan_eq_krylovSpan T (fun i => z (k - 1 - i)) v k

/-- **The rational (resolvent) Krylov space is the image of the ordinary Krylov space
under the product of all `k` resolvents.** -/
theorem resolventSpan_eq_map_krylovSpan (hX : IsResolventFamily T z X) (v : V) (k : ℕ) :
    resolventSpan X v k = Submodule.map (resProd X k) (krylovSpan T v k) := by
  rw [← tailSpan_eq_krylovSpan T z v k, Submodule.map_span, resolventSpan]
  congr 1
  ext x
  constructor
  · rintro ⟨j, hj, rfl⟩
    refine ⟨tailProd T z j k v, ⟨j, hj, rfl⟩, ?_⟩
    rw [← Module.End.mul_apply, resProd_mul_tailProd hX k hj]
  · rintro ⟨y, ⟨j, hj, rfl⟩, rfl⟩
    refine ⟨j, hj, ?_⟩
    rw [← Module.End.mul_apply, resProd_mul_tailProd hX k hj]

/-! ## 4. The two spans are carried into each other by inverse operators -/

/-- The resolvent product is a left inverse of the forward product. -/
theorem resProd_mul_forwardProd (hX : IsResolventFamily T z X) :
    ∀ k, resProd X k * forwardProd T z k = 1 := by
  intro k
  induction k with
  | zero => simp [resProd, forwardProd]
  | succ n ih =>
    rw [resProd_succ, forwardProd_succ]
    calc X n * resProd X n * (shiftOp T (z n) * forwardProd T z n)
        = X n * (resProd X n * shiftOp T (z n)) * forwardProd T z n := by
          simp only [mul_assoc]
      _ = X n * (shiftOp T (z n) * resProd X n) * forwardProd T z n := by
          rw [(commute_resProd_shiftOp hX (z n) n).eq]
      _ = (X n * shiftOp T (z n)) * (resProd X n * forwardProd T z n) := by
          simp only [mul_assoc]
      _ = 1 := by rw [(hX n).1, ih, one_mul]

/-- The resolvent product is a right inverse of the forward product. -/
theorem forwardProd_mul_resProd (hX : IsResolventFamily T z X) :
    ∀ k, forwardProd T z k * resProd X k = 1 := by
  intro k
  induction k with
  | zero => simp [resProd, forwardProd]
  | succ n ih =>
    rw [resProd_succ, forwardProd_succ]
    calc shiftOp T (z n) * forwardProd T z n * (X n * resProd X n)
        = shiftOp T (z n) * (forwardProd T z n * X n) * resProd X n := by
          simp only [mul_assoc]
      _ = shiftOp T (z n) * (X n * forwardProd T z n) * resProd X n := by
          rw [(commute_resolvent_forwardProd hX n n).eq]
      _ = (shiftOp T (z n) * X n) * (forwardProd T z n * resProd X n) := by
          simp only [mul_assoc]
      _ = 1 := by rw [(hX n).2, ih, one_mul]

/-- The inverse form of `resolventSpan_eq_map_krylovSpan`: the forward product carries
the rational Krylov space back onto the ordinary Krylov space. -/
theorem krylovSpan_eq_map_resolventSpan (hX : IsResolventFamily T z X) (v : V) (k : ℕ) :
    krylovSpan T v k = Submodule.map (forwardProd T z k) (resolventSpan X v k) := by
  rw [resolventSpan_eq_map_krylovSpan hX v k, ← Submodule.map_comp]
  have : (forwardProd T z k) ∘ₗ (resProd X k) = (1 : Module.End R V) :=
    forwardProd_mul_resProd hX k
  rw [this]
  exact (Submodule.map_id _).symm

/-! ## 5. The rational Krylov vectors -/

/-- The **rational Krylov sequence** `v, X₀v, X₁X₀v, …` — the vectors the solver actually
computes, one resolvent solve at a time. -/
def resVec (X : ℕ → Module.End R V) (v : V) : ℕ → V
  | 0 => v
  | (n + 1) => X n (resVec X v n)

@[simp] theorem resVec_zero (X : ℕ → Module.End R V) (v : V) : resVec X v 0 = v := rfl

theorem resVec_succ (X : ℕ → Module.End R V) (v : V) (n : ℕ) :
    resVec X v (n + 1) = X n (resVec X v n) := rfl

/-- The rational Krylov vectors are exactly the resolvent products applied to `v`. -/
theorem resVec_eq_resProd_apply (X : ℕ → Module.End R V) (v : V) :
    ∀ n, resVec X v n = resProd X n v := by
  intro n
  induction n with
  | zero => rfl
  | succ m ih => rw [resVec_succ, ih, resProd_succ, Module.End.mul_apply]

/-- `resolventSpan` is the span of the rational Krylov sequence, in the form in which the
Hashimoto–Nodera scheme writes it. -/
theorem resolventSpan_eq_span_resVec (X : ℕ → Module.End R V) (v : V) (k : ℕ) :
    resolventSpan X v k = Submodule.span R (resVec X v '' {j | j ≤ k}) := by
  rw [resolventSpan]
  congr 1
  ext x
  constructor
  · rintro ⟨j, hj, rfl⟩
    exact ⟨j, hj, resVec_eq_resProd_apply X v j⟩
  · rintro ⟨j, hj, rfl⟩
    exact ⟨j, hj, resVec_eq_resProd_apply X v j⟩


/-! ## 6. Reordering the shift schedule -/

/-- `resProd` as the product of the list of the first `k` resolvents. -/
theorem resProd_eq_list_prod (X : ℕ → Module.End R V) :
    ∀ k, resProd X k = (((List.range k).map X).reverse).prod := by
  intro k
  induction k with
  | zero => simp [resProd]
  | succ n ih => rw [resProd_succ, ih, List.range_succ]; simp

/-- The list of the first `k` resolvents is pairwise commuting. -/
theorem pairwise_commute_resList (hX : IsResolventFamily T z X) (l : List ℕ) :
    List.Pairwise Commute (l.map X) := by
  rw [List.pairwise_map]
  exact List.pairwise_iff_forall_sublist.mpr fun {a b} _ => commute_resolvent hX a b

/-- A permutation of `ℕ` fixing everything from `k` on permutes `Finset.range k`. -/
theorem image_range_of_perm (σ : Equiv.Perm ℕ) (k : ℕ) (hσ : ∀ i, k ≤ i → σ i = i) :
    Finset.image σ (Finset.range k) = Finset.range k := by
  have hlt : ∀ j, j < k → σ j < k := by
    intro j hj
    by_contra hc
    have := hσ (σ j) (by omega)
    have : σ j = j := σ.injective this
    omega
  refine Finset.eq_of_subset_of_card_le ?_ ?_
  · intro i hi
    rcases Finset.mem_image.mp hi with ⟨j, hj, rfl⟩
    exact Finset.mem_range.mpr (hlt j (Finset.mem_range.mp hj))
  · rw [Finset.card_image_of_injective _ σ.injective]

/-- **The product of the first `k` resolvents does not depend on the order of the
shifts.** -/
theorem resProd_of_perm (hX : IsResolventFamily T z X) (σ : Equiv.Perm ℕ) (k : ℕ)
    (hσ : ∀ i, k ≤ i → σ i = i) :
    resProd (fun i => X (σ i)) k = resProd X k := by
  have hmul : ((List.range k).map σ).Perm (List.range k) := by
    have hval : (Finset.image σ (Finset.range k)).val = (Finset.range k).val := by
      rw [image_range_of_perm σ k hσ]
    rw [Finset.image_val_of_injOn (Set.injOn_of_injective σ.injective)] at hval
    exact Quotient.exact hval
  have hperm : (((List.range k).map fun i => X (σ i)).reverse).Perm
      (((List.range k).map X).reverse) := by
    have h1 : ((List.range k).map fun i => X (σ i)) = ((List.range k).map σ).map X := by
      simp [List.map_map, Function.comp_def]
    rw [h1]
    exact (List.reverse_perm _).trans ((hmul.map X).trans (List.reverse_perm _).symm)
  rw [resProd_eq_list_prod, resProd_eq_list_prod]
  refine List.Perm.prod_eq' hperm ?_
  have h1 : ((List.range k).map fun i => X (σ i)) = ((List.range k).map σ).map X := by
    simp [List.map_map, Function.comp_def]
  rw [h1, ← List.map_reverse]
  exact pairwise_commute_resList hX _

/-- **The rational Krylov space does not depend on the order in which the shifts are
used.**  Reordering the schedule changes the intermediate flag, but not the space it
ends at. -/
theorem resolventSpan_of_perm (hX : IsResolventFamily T z X) (σ : Equiv.Perm ℕ) (k : ℕ)
    (hσ : ∀ i, k ≤ i → σ i = i) (v : V) :
    resolventSpan (fun i => X (σ i)) v k = resolventSpan X v k := by
  have hX' : IsResolventFamily T (fun i => z (σ i)) (fun i => X (σ i)) := fun i => hX (σ i)
  rw [resolventSpan_eq_map_krylovSpan hX' v k, resolventSpan_eq_map_krylovSpan hX v k,
    resProd_of_perm hX σ k hσ]

end Resolvent

end BookProof.KrylovShiftSpan
