import Mathlib
import BookProof.ChapterNavierStokesIkebeKato

/-!
# The two Faris–Lavine inequalities, verified for the Navier–Stokes generator

Everywhere else on this route the two Faris–Lavine inequalities

* the relative bound `‖H x‖² ≤ a‖N x‖² + b‖x‖²`, and
* the form-commutator bound `± i[H, N] ≤ c N`,

are *hypotheses* on the Hamiltonian.  Here they are **proved**, for a concrete
Hamiltonian in a representation in which the momentum and the fiber coordinate
genuinely do **not** commute — so that the commutator `[H, N]` is genuinely
non-zero (`commForm_ne_zero_of_pos`), and the Faris–Lavine mechanism (the
non-commuting cross terms `π · V` are dominated by the sum of the squares
`π² + V²`) is what makes the argument work.

## The model

On the fiber, the one-particle Navier–Stokes transport operator is the symmetric
first-order operator
`h = ½ (πᵢ Vᵢ + Vᵢ πᵢ)`,
with `πᵢ = -i ∂/∂uᵢ` and with the *linear* advection field `Vᵢ(u) = Mᵢⱼuⱼ + Cᵢ`.
The comparison operator is built, as Faris–Lavine requires, from the squares of
the individual non-commuting pieces:
`N = πᵢπᵢ + Vᵢ(u)Vᵢ(u) + I ≥ I`.

Take one fiber degree of freedom and the linear field `V(u) = κ u` (`κ ≥ 0` the
strain rate).  In the Hermite (harmonic-oscillator) basis `eₙ` of `L²(du)`,
normalised so that
`u = (a + a†)/√(2κ)`, `π = i√(κ/2)(a† - a)` — hence `[π, u] = -i`, `nsComm_pu` —
one has

* `N = π² + V² + I = κ(2n̂ + 1) + I`: **diagonal**, multiplication by the symbol
  `oscSymbol κ n = κ(2n+1) + 1 ≥ 1` (`nsN_core_eq`);
* `H = ½(πV + Vπ) = (iκ/2)(a†² - a²)`: the **±2-shift** operator
  `(Hx)ₘ = i(w(m-2) x(m-2) - w(m) x(m+2))`, `w(n) = (κ/2)√((n+1)(n+2))`
  (`nsH`, `nsH_core_eq`).

`H` is *not* diagonal, and `[H, N] = -2iκ²(a² + a†²) ≠ 0`.

## What is proved

* `nsH_symmetricOn` — `H` is symmetric on the maximal domain of `N`;
* `nsH_relative_bound` — **the first Faris–Lavine inequality**
  `‖Hx‖² ≤ ½‖Nx‖² + 2κ²‖x‖²`;
* `nsH_commForm_bound` — **the second Faris–Lavine inequality**
  `|⟪x, i[H,N]x⟫| ≤ (2κ + 4κ²) ⟪x, Nx⟫`, proved exactly by the mechanism of the
  theorem: the commutator is the cross term `∝ κ² (a² + a†²)`, and
  `2ab ≤ a² + b²` dominates it by `π² + V² + I = N`;
* `commForm_ne_zero_of_pos` — the commutator form is genuinely non-zero, so the
  bound is not vacuous;
* `nsH_essentiallySelfAdjointOn_core` — consequently, by the Faris–Lavine theorem
  of `BookProof.ChapterFarisLavine` together with the Ikebe–Kato input of
  `BookProof.ChapterNavierStokesIkebeKato`, **the Navier–Stokes fiber Hamiltonian
  is essentially self-adjoint on the finite-mode core**, with no hypothesis left.

Nothing here claims global regularity for the Navier–Stokes equation.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace HermiteFarisLavine

open LpNat FarisLavine IkebeKato

/-! ## Shifting a sequence by two -/

/-- `shift2 g` is the sequence `g` moved two places up (and `0` on the first two
indices). -/
def shift2 {M : Type*} [Zero M] (g : ℕ → M) : ℕ → M := fun m => if 2 ≤ m then g (m - 2) else 0

@[simp] theorem shift2_add_two {M : Type*} [Zero M] (g : ℕ → M) (n : ℕ) :
    shift2 g (n + 2) = g n := by
  simp [shift2]

@[simp] theorem shift2_zero_apply {M : Type*} [Zero M] (g : ℕ → M) : shift2 g 0 = 0 := rfl

@[simp] theorem shift2_one_apply {M : Type*} [Zero M] (g : ℕ → M) : shift2 g 1 = 0 := rfl

theorem hasSum_shift2_iff {M : Type*} [AddCommGroup M] [TopologicalSpace M]
    [IsTopologicalAddGroup M] {g : ℕ → M} {s : M} : HasSum (shift2 g) s ↔ HasSum g s := by
  have h := hasSum_nat_add_iff (f := shift2 g) (g := s) 2
  have hfun : (fun n => shift2 g (n + 2)) = g := funext fun n => shift2_add_two g n
  rw [hfun] at h
  have hz : (∑ i ∈ Finset.range 2, shift2 g i) = 0 := by
    simp [Finset.sum_range_succ, shift2]
  rw [hz, add_zero] at h
  exact h.symm

theorem summable_shift2 {M : Type*} [AddCommGroup M] [UniformSpace M] [IsTopologicalAddGroup M]
    [CompleteSpace M] [T2Space M] {g : ℕ → M} (h : Summable g) : Summable (shift2 g) :=
  (hasSum_shift2_iff.mpr h.hasSum).summable

/-- Squaring commutes with the shift. -/
theorem shift2_sq (g : ℕ → ℝ) (m : ℕ) : shift2 (fun n => g n ^ 2) m = (shift2 g m) ^ 2 := by
  by_cases h : 2 ≤ m <;> simp [shift2, h]

/-- A shifted non-negative sequence is non-negative. -/
theorem shift2_nonneg (g : ℕ → ℝ) (h : ∀ n, 0 ≤ g n) (m : ℕ) : 0 ≤ shift2 g m := by
  by_cases hm : 2 ≤ m <;> simp [shift2, hm, h]

/-- The norm of a shifted complex sequence. -/
theorem norm_shift2 (g : ℕ → ℂ) (m : ℕ) : ‖shift2 g m‖ = shift2 (fun n => ‖g n‖) m := by
  by_cases h : 2 ≤ m <;> simp [shift2, h]

/-! ## The symbol and the amplitudes of the Hermite representation -/

/-- The symbol of the comparison operator `N = π² + V² + I = κ(2n̂+1) + I` in the
Hermite basis. -/
def oscSymbol (κ : ℝ) : ℕ → ℝ := fun n => κ * (2 * n + 1) + 1

/-- The off-diagonal amplitude of the Navier–Stokes fiber Hamiltonian
`H = ½(πV + Vπ) = (iκ/2)(a†² - a²)` in the Hermite basis: `H eₙ` has the
component `i w(n)` on `eₙ₊₂` and `-i w(n-2)` on `eₙ₋₂`. -/
noncomputable def amp (κ : ℝ) (n : ℕ) : ℝ := (κ / 2) * Real.sqrt ((n + 1) * (n + 2))

variable {κ : ℝ}

theorem oscSymbol_ge_one (hκ : 0 ≤ κ) (n : ℕ) : 1 ≤ oscSymbol κ n := by
  have : (0 : ℝ) ≤ κ * (2 * n + 1) := by positivity
  simp only [oscSymbol]; linarith

theorem oscSymbol_nonneg (hκ : 0 ≤ κ) (n : ℕ) : 0 ≤ oscSymbol κ n :=
  le_trans zero_le_one (oscSymbol_ge_one hκ n)

theorem oscSymbol_step (n : ℕ) : oscSymbol κ (n + 2) = oscSymbol κ n + 4 * κ := by
  simp only [oscSymbol]
  push_cast
  ring

theorem amp_nonneg (hκ : 0 ≤ κ) (n : ℕ) : 0 ≤ amp κ n := by
  have : (0 : ℝ) ≤ Real.sqrt ((n + 1) * (n + 2)) := Real.sqrt_nonneg _
  simp only [amp]
  positivity

/-- The amplitude increases along the shift. -/
theorem amp_le_amp_add_two (hκ : 0 ≤ κ) (n : ℕ) : amp κ n ≤ amp κ (n + 2) := by
  have hmono : Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2))
      ≤ Real.sqrt ((((n : ℝ) + 2) + 1) * (((n : ℝ) + 2) + 2)) := by
    apply Real.sqrt_le_sqrt
    nlinarith [Nat.cast_nonneg (α := ℝ) n]
  simp only [amp]
  push_cast
  nlinarith [hmono, Real.sqrt_nonneg (((n : ℝ) + 1) * ((n : ℝ) + 2))]

/-- **The amplitude is dominated by the comparison symbol**: this is the
inequality `w(n) ≤ ¼ N(n) + κ/2` behind both Faris–Lavine bounds. -/
theorem amp_le_quarter (hκ : 0 ≤ κ) (n : ℕ) : amp κ n ≤ (1 / 4) * oscSymbol κ n + κ / 2 := by
  have hs : Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2)) ≤ (n : ℝ) + 3 / 2 := by
    have h1 : ((n : ℝ) + 1) * ((n : ℝ) + 2) ≤ ((n : ℝ) + 3 / 2) ^ 2 := by nlinarith
    have h2 : Real.sqrt (((n : ℝ) + 3 / 2) ^ 2) = (n : ℝ) + 3 / 2 := by
      rw [Real.sqrt_sq (by positivity)]
    calc Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2))
        ≤ Real.sqrt (((n : ℝ) + 3 / 2) ^ 2) := Real.sqrt_le_sqrt h1
      _ = (n : ℝ) + 3 / 2 := h2
  have hmul : (κ / 2) * Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2)) ≤ (κ / 2) * ((n : ℝ) + 3 / 2) :=
    mul_le_mul_of_nonneg_left hs (by linarith)
  simp only [amp, oscSymbol]
  linarith

/-- The amplitude is dominated by a multiple of the symbol (which is `≥ 1`). -/
theorem amp_le_symbol (hκ : 0 ≤ κ) (n : ℕ) :
    amp κ n ≤ (1 / 4 + κ / 2) * oscSymbol κ n := by
  have h1 := amp_le_quarter hκ n
  have h2 : (1 : ℝ) ≤ oscSymbol κ n := oscSymbol_ge_one hκ n
  nlinarith

/-! ## The Hamiltonian as a `±2`-shift operator -/

/-- The Navier–Stokes fiber Hamiltonian `H = ½(πV + Vπ) = (iκ/2)(a†² - a²)` acting on
coordinates: `(Hx)ₘ = i(w(m-2) xₘ₋₂ - w(m) xₘ₊₂)`. -/
noncomputable def hFun (κ : ℝ) (X : ℕ → ℂ) : ℕ → ℂ :=
  fun m => Complex.I * (shift2 (fun n => (amp κ n : ℂ) * X n) m - (amp κ m : ℂ) * X (m + 2))

/-- The sequence of amplitudes weighted by the state: `w(n)|xₙ|`. -/
noncomputable def ampSeq (κ : ℝ) (X : ℕ → ℂ) : ℕ → ℝ := fun n => amp κ n * ‖X n‖

theorem ampSeq_nonneg (hκ : 0 ≤ κ) (X : ℕ → ℂ) (n : ℕ) : 0 ≤ ampSeq κ X n :=
  mul_nonneg (amp_nonneg hκ n) (norm_nonneg _)

/-- The pointwise bound on the Hamiltonian: two hops, each weighted by an
amplitude. -/
theorem norm_hFun_le (hκ : 0 ≤ κ) (X : ℕ → ℂ) (m : ℕ) :
    ‖hFun κ X m‖ ≤ shift2 (ampSeq κ X) m + ampSeq κ X (m + 2) := by
  have hnorm1 : ‖shift2 (fun n => (amp κ n : ℂ) * X n) m‖ = shift2 (ampSeq κ X) m := by
    rw [norm_shift2]
    have : (fun n => ‖(amp κ n : ℂ) * X n‖) = ampSeq κ X := by
      funext n
      rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (amp_nonneg hκ n)]
      rfl
    rw [this]
  have hnorm2 : ‖(amp κ m : ℂ) * X (m + 2)‖ ≤ ampSeq κ X (m + 2) := by
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (amp_nonneg hκ m)]
    exact mul_le_mul_of_nonneg_right (amp_le_amp_add_two hκ m) (norm_nonneg _)
  calc ‖hFun κ X m‖
      = ‖shift2 (fun n => (amp κ n : ℂ) * X n) m - (amp κ m : ℂ) * X (m + 2)‖ := by
        simp [hFun]
    _ ≤ ‖shift2 (fun n => (amp κ n : ℂ) * X n) m‖ + ‖(amp κ m : ℂ) * X (m + 2)‖ :=
        norm_sub_le _ _
    _ ≤ shift2 (ampSeq κ X) m + ampSeq κ X (m + 2) := by rw [hnorm1]; linarith

/-! ## Square summability -/

/-- The squared norm of an `ℓ²` state is the sum of the squared moduli. -/
theorem hasSum_normSq {ι : Type*} (f : L2I ι) :
    HasSum (fun k => ‖(f : ι → ℂ) k‖ ^ 2) (‖f‖ ^ 2) := by
  have h := lp.hasSum_norm (p := 2) (E := fun _ : ι => ℂ) (by norm_num) f
  have h2 : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  rw [h2] at h
  simpa [Real.rpow_natCast] using h

section Domain

variable {x : maxDom (oscSymbol κ)}

theorem norm_diagMax_coe (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) (n : ℕ) :
    ‖((diagMax (oscSymbol κ) x : L2I ℕ) : ℕ → ℂ) n‖
      = oscSymbol κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ := by
  rw [diagMax_coe, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (oscSymbol_nonneg hκ n)]

/-- The comparison series that dominates the amplitudes. -/
theorem hasSum_ampBound (x : maxDom (oscSymbol κ)) :
    HasSum (fun n => (1 / 8) * ‖((diagMax (oscSymbol κ) x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2
        + (κ ^ 2 / 2) * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2)
      ((1 / 8) * ‖(diagMax (oscSymbol κ) x : L2I ℕ)‖ ^ 2 + (κ ^ 2 / 2) * ‖(x : L2I ℕ)‖ ^ 2) :=
  ((hasSum_normSq _).mul_left _).add ((hasSum_normSq _).mul_left _)

/-- **The amplitude is dominated by the comparison operator**, squared: the
analytic content of the first Faris–Lavine inequality. -/
theorem ampSeq_sq_le (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) (n : ℕ) :
    (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2
      ≤ (1 / 8) * ‖((diagMax (oscSymbol κ) x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2
        + (κ ^ 2 / 2) * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2 := by
  have hle := amp_le_quarter hκ n
  have hnn : 0 ≤ ‖((x : L2I ℕ) : ℕ → ℂ) n‖ := norm_nonneg _
  have hamp : 0 ≤ amp κ n := amp_nonneg hκ n
  have hA2 : amp κ n ^ 2 ≤ (1 / 8) * oscSymbol κ n ^ 2 + κ ^ 2 / 2 := by
    nlinarith [sq_nonneg (oscSymbol κ n / 4 - κ / 2)]
  rw [norm_diagMax_coe hκ x n]
  simp only [ampSeq]
  nlinarith [hA2, sq_nonneg ‖((x : L2I ℕ) : ℕ → ℂ) n‖]

theorem summable_ampSeq_sq (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    Summable (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2) :=
  Summable.of_nonneg_of_le (fun _ => sq_nonneg _) (ampSeq_sq_le hκ x)
    (hasSum_ampBound x).summable

theorem tsum_ampSeq_sq_le (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    (∑' n, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2)
      ≤ (1 / 8) * ‖(diagMax (oscSymbol κ) x : L2I ℕ)‖ ^ 2 + (κ ^ 2 / 2) * ‖(x : L2I ℕ)‖ ^ 2 := by
  refine le_trans (Summable.tsum_le_tsum (ampSeq_sq_le hκ x) (summable_ampSeq_sq hκ x)
    (hasSum_ampBound x).summable) ?_
  exact le_of_eq (hasSum_ampBound x).tsum_eq

/-- The Hamiltonian maps the maximal domain of the comparison operator into the
Hilbert space. -/
theorem memLp_hFun (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    Memℓp (hFun κ ((x : L2I ℕ) : ℕ → ℂ)) 2 := by
  refine memLpTwo_of_summable_normSq ?_
  have hS := summable_ampSeq_sq hκ x
  have hshift : Summable (shift2 (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2)) :=
    summable_shift2 hS
  have htail : Summable (fun m => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2)) ^ 2) :=
    (summable_nat_add_iff 2).mpr hS
  refine Summable.of_nonneg_of_le (fun m => sq_nonneg _) ?_
    ((hshift.mul_left 2).add (htail.mul_left 2))
  intro m
  have h1 := norm_hFun_le hκ ((x : L2I ℕ) : ℕ → ℂ) m
  have h2 : 0 ≤ shift2 (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ)) m :=
    shift2_nonneg _ (ampSeq_nonneg hκ _) m
  have h3 : 0 ≤ ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2) := ampSeq_nonneg hκ _ _
  have h4 := mul_self_le_mul_self (norm_nonneg (hFun κ ((x : L2I ℕ) : ℕ → ℂ) m)) h1
  rw [shift2_sq]
  nlinarith [h4, sq_nonneg (shift2 (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ)) m
    - ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2))]

/-- **The Navier–Stokes fiber Hamiltonian** `H = ½(πV + Vπ)`, on the maximal
domain of the comparison operator `N = π² + V² + I`. -/
noncomputable def nsH (κ : ℝ) (hκ : 0 ≤ κ) : maxDom (oscSymbol κ) →ₗ[ℂ] L2I ℕ where
  toFun x := ⟨hFun κ ((x : L2I ℕ) : ℕ → ℂ), memLp_hFun hκ x⟩
  map_add' x y := by
    refine lp.ext (funext fun m => ?_)
    simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add, hFun, shift2]
    by_cases h : 2 ≤ m <;> simp [h] <;> ring
  map_smul' a x := by
    refine lp.ext (funext fun m => ?_)
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply, Submodule.coe_smul,
      hFun, shift2]
    by_cases h : 2 ≤ m <;> simp [h] <;> ring

@[simp] theorem nsH_coe (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) (m : ℕ) :
    ((nsH κ hκ x : L2I ℕ) : ℕ → ℂ) m = hFun κ ((x : L2I ℕ) : ℕ → ℂ) m := rfl


/-! ## The inner products of the Hamiltonian

`⟪Hx, y⟫` splits into the two "hopping" series `A` (a particle moves two levels
up) and `B` (two levels down).  Both are absolutely convergent because
`2ab ≤ a² + b²`, and this is the only place where convergence is used. -/

/-- The upward hopping series `w(n) x̄ₙ yₙ₊₂`. -/
noncomputable def crossA (κ : ℝ) (X Y : ℕ → ℂ) : ℕ → ℂ :=
  fun n => (amp κ n : ℂ) * (starRingEnd ℂ) (X n) * Y (n + 2)

/-- The downward hopping series `w(n) x̄ₙ₊₂ yₙ`. -/
noncomputable def crossB (κ : ℝ) (X Y : ℕ → ℂ) : ℕ → ℂ :=
  fun n => (amp κ n : ℂ) * (starRingEnd ℂ) (X (n + 2)) * Y n

theorem norm_crossA (hκ : 0 ≤ κ) (X Y : ℕ → ℂ) (n : ℕ) :
    ‖crossA κ X Y n‖ = ampSeq κ X n * ‖Y (n + 2)‖ := by
  simp only [crossA, ampSeq, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (amp_nonneg hκ n), RCLike.norm_conj]

theorem norm_crossB (hκ : 0 ≤ κ) (X Y : ℕ → ℂ) (n : ℕ) :
    ‖crossB κ X Y n‖ = amp κ n * ‖X (n + 2)‖ * ‖Y n‖ := by
  simp only [crossB, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (amp_nonneg hκ n), RCLike.norm_conj]

/-- Absolute convergence of the hopping series, from `2ab ≤ a² + b²`. -/
theorem summable_crossA (hκ : 0 ≤ κ) {X Y : ℕ → ℂ}
    (hX : Summable fun n => (ampSeq κ X n) ^ 2) (hY : Summable fun n => ‖Y n‖ ^ 2) :
    Summable (crossA κ X Y) := by
  refine Summable.of_norm (Summable.of_nonneg_of_le (fun n => norm_nonneg _) (fun n => ?_)
    ((hX.add ((summable_nat_add_iff 2).mpr hY)).mul_left (1 / 2)))
  rw [norm_crossA hκ]
  nlinarith [sq_nonneg (ampSeq κ X n - ‖Y (n + 2)‖), ampSeq_nonneg hκ X n, norm_nonneg (Y (n + 2))]

theorem summable_crossB (hκ : 0 ≤ κ) {X Y : ℕ → ℂ}
    (hX : Summable fun n => (ampSeq κ X n) ^ 2) (hY : Summable fun n => ‖Y n‖ ^ 2) :
    Summable (crossB κ X Y) := by
  refine Summable.of_norm (Summable.of_nonneg_of_le (fun n => norm_nonneg _) (fun n => ?_)
    ((((summable_nat_add_iff 2).mpr hX).add hY).mul_left (1 / 2)))
  rw [norm_crossB hκ]
  have hmono : amp κ n * ‖X (n + 2)‖ ≤ ampSeq κ X (n + 2) :=
    mul_le_mul_of_nonneg_right (amp_le_amp_add_two hκ n) (norm_nonneg _)
  have h0 : 0 ≤ ‖Y n‖ := norm_nonneg _
  nlinarith [sq_nonneg (ampSeq κ X (n + 2) - ‖Y n‖), ampSeq_nonneg hκ X (n + 2),
    mul_le_mul_of_nonneg_right hmono h0]

/-- The coordinatewise form of `⟪Hx, y⟫`. -/
theorem conj_hFun_mul (κ : ℝ) (X Y : ℕ → ℂ) (m : ℕ) :
    (starRingEnd ℂ) (hFun κ X m) * Y m
      = -Complex.I * shift2 (crossA κ X Y) m + Complex.I * crossB κ X Y m := by
  rcases Nat.lt_or_ge m 2 with hm | hm
  · interval_cases m <;>
      simp [hFun, crossB, shift2, Complex.ext_iff] <;>
      constructor <;> ring
  · obtain ⟨k, rfl⟩ : ∃ k, m = k + 2 := ⟨m - 2, by omega⟩
    simp only [hFun, crossA, crossB, shift2_add_two, map_mul, Complex.conj_I,
      Complex.conj_ofReal, map_sub]
    ring

/-- The coordinatewise form of `⟪x, Hy⟫`. -/
theorem conj_mul_hFun (κ : ℝ) (X Y : ℕ → ℂ) (m : ℕ) :
    (starRingEnd ℂ) (X m) * hFun κ Y m
      = -Complex.I * crossA κ X Y m + Complex.I * shift2 (crossB κ X Y) m := by
  rcases Nat.lt_or_ge m 2 with hm | hm
  · interval_cases m <;>
      simp [hFun, crossA, shift2, Complex.ext_iff] <;>
      constructor <;> ring
  · obtain ⟨k, rfl⟩ : ∃ k, m = k + 2 := ⟨m - 2, by omega⟩
    simp only [hFun, crossA, crossB, shift2_add_two]
    ring

/-- **The two hopping series compute `⟪Hx, y⟫`.** -/
theorem hasSum_inner_nsH_left (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) (y : L2I ℕ) :
    HasSum (fun n => -Complex.I * crossA κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ)) n
        + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ)) n)
      (inner ℂ (nsH κ hκ x : L2I ℕ) y) := by
  have hA := summable_crossA (Y := (y : ℕ → ℂ)) hκ (summable_ampSeq_sq hκ x) (summable_normSq y)
  have hB := summable_crossB (Y := (y : ℕ → ℂ)) hκ (summable_ampSeq_sq hκ x) (summable_normSq y)
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := ((hasSum_shift2_iff.mpr hA.hasSum).mul_left (-Complex.I)).add
    (hB.hasSum.mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((nsH κ hκ x : L2I ℕ)) y
  have heq : (fun m => (inner ℂ (((nsH κ hκ x : L2I ℕ) : ℕ → ℂ) m) ((y : ℕ → ℂ) m) : ℂ))
      = fun m => -Complex.I * shift2 (crossA κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ))) m
          + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ)) m := by
    funext m
    rw [RCLike.inner_apply, nsH_coe, mul_comm]
    exact conj_hFun_mul κ _ _ m
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal

/-- **The two hopping series compute `⟪x, Hy⟫`** — the same two series. -/
theorem hasSum_inner_nsH_right (hκ : 0 ≤ κ) (x y : maxDom (oscSymbol κ)) :
    HasSum (fun n => -Complex.I * crossA κ ((x : L2I ℕ) : ℕ → ℂ) (((y : L2I ℕ) : ℕ → ℂ)) n
        + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ) (((y : L2I ℕ) : ℕ → ℂ)) n)
      (inner ℂ (x : L2I ℕ) (nsH κ hκ y : L2I ℕ)) := by
  have hA := summable_crossA (Y := ((y : L2I ℕ) : ℕ → ℂ)) hκ (summable_ampSeq_sq hκ x)
    (summable_normSq (y : L2I ℕ))
  have hB := summable_crossB (Y := ((y : L2I ℕ) : ℕ → ℂ)) hκ (summable_ampSeq_sq hκ x)
    (summable_normSq (y : L2I ℕ))
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := (hA.hasSum.mul_left (-Complex.I)).add
    ((hasSum_shift2_iff.mpr hB.hasSum).mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((x : L2I ℕ)) ((nsH κ hκ y : L2I ℕ))
  have heq : (fun m => (inner ℂ (((x : L2I ℕ) : ℕ → ℂ) m)
        (((nsH κ hκ y : L2I ℕ) : ℕ → ℂ) m) : ℂ))
      = fun m => -Complex.I * crossA κ ((x : L2I ℕ) : ℕ → ℂ) (((y : L2I ℕ) : ℕ → ℂ)) m
          + Complex.I * shift2 (crossB κ ((x : L2I ℕ) : ℕ → ℂ) (((y : L2I ℕ) : ℕ → ℂ))) m := by
    funext m
    rw [RCLike.inner_apply, nsH_coe, mul_comm]
    exact conj_mul_hFun κ _ _ m
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal

/-- **The Navier–Stokes fiber Hamiltonian is symmetric** on the maximal domain of
the comparison operator. -/
theorem nsH_symmetricOn (hκ : 0 ≤ κ) : SymmetricOn (maxDom (oscSymbol κ)) (nsH κ hκ) := by
  intro x y
  exact (hasSum_inner_nsH_left hκ x (y : L2I ℕ)).unique (hasSum_inner_nsH_right hκ x y)


/-! ## The first Faris–Lavine inequality: the relative bound -/

/-- The pointwise square bound behind the relative bound. -/
theorem normSq_hFun_le (hκ : 0 ≤ κ) (X : ℕ → ℂ) (m : ℕ) :
    ‖hFun κ X m‖ ^ 2
      ≤ 2 * shift2 (fun n => (ampSeq κ X n) ^ 2) m + 2 * (ampSeq κ X (m + 2)) ^ 2 := by
  have h1 := norm_hFun_le hκ X m
  have h2 : 0 ≤ shift2 (ampSeq κ X) m := shift2_nonneg _ (ampSeq_nonneg hκ _) m
  have h3 : 0 ≤ ampSeq κ X (m + 2) := ampSeq_nonneg hκ _ _
  have h4 := mul_self_le_mul_self (norm_nonneg (hFun κ X m)) h1
  rw [shift2_sq]
  nlinarith [h4, sq_nonneg (shift2 (ampSeq κ X) m - ampSeq κ X (m + 2))]

/-- The tail of a non-negative series is bounded by the whole series. -/
theorem tsum_shift_le {f : ℕ → ℝ} (hf : Summable f) (hnn : ∀ n, 0 ≤ f n) :
    (∑' n, f (n + 2)) ≤ ∑' n, f n := by
  have h := hf.sum_add_tsum_nat_add 2
  have h0 : 0 ≤ ∑ i ∈ Finset.range 2, f i := Finset.sum_nonneg fun i _ => hnn i
  linarith [h]

/-- **The first Faris–Lavine inequality for the Navier–Stokes Hamiltonian**:
`‖Hx‖² ≤ ½‖Nx‖² + 2κ²‖x‖²`.  The Hamiltonian is relatively bounded by the
comparison operator built from the squares of its non-commuting pieces. -/
theorem nsH_relative_bound (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    ‖(nsH κ hκ x : L2I ℕ)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax (oscSymbol κ) x : L2I ℕ)‖ ^ 2 + (2 * κ ^ 2) * ‖(x : L2I ℕ)‖ ^ 2 := by
  have hS := summable_ampSeq_sq hκ x
  have hshift : Summable (shift2 (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2)) :=
    summable_shift2 hS
  have htail : Summable (fun m => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2)) ^ 2) :=
    (summable_nat_add_iff 2).mpr hS
  have hbound := (hshift.hasSum.mul_left 2).add (htail.hasSum.mul_left 2)
  have hle : ‖(nsH κ hκ x : L2I ℕ)‖ ^ 2
      ≤ 2 * (∑' m, shift2 (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2) m)
        + 2 * ∑' m, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2)) ^ 2 := by
    refine hasSum_le (fun m => ?_) (hasSum_normSq (nsH κ hκ x : L2I ℕ)) hbound
    rw [nsH_coe]
    exact normSq_hFun_le hκ _ m
  have hshifteq : (∑' m, shift2 (fun n => (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2) m)
      = ∑' n, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2 :=
    (hasSum_shift2_iff.mpr hS.hasSum).tsum_eq
  have htaille : (∑' m, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) (m + 2)) ^ 2)
      ≤ ∑' n, (ampSeq κ ((x : L2I ℕ) : ℕ → ℂ) n) ^ 2 :=
    tsum_shift_le hS (fun n => sq_nonneg _)
  have hT := tsum_ampSeq_sq_le hκ x
  rw [hshifteq] at hle
  linarith

/-! ## The second Faris–Lavine inequality: the commutator form -/

/-- **The commutator form of the Navier–Stokes Hamiltonian with its comparison
operator.**  `i[H, N] = -2κ²(a² + a†²)` is *not* zero: the momentum and the
advection field do not commute, and the commutator is the cross term.  Its
expectation is the series `8κ ∑ₙ w(n) Re(x̄ₙ xₙ₊₂)`. -/
theorem hasSum_commForm (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    HasSum (fun n => 8 * κ * (amp κ n
        * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n) * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re))
      (commForm (nsH κ hκ) (diagMax (oscSymbol κ)) x) := by
  have hL := hasSum_inner_nsH_left hκ x (diagMax (oscSymbol κ) x : L2I ℕ)
  have hIm := Complex.hasSum_im hL
  have hpt : ∀ n, (-Complex.I * crossA κ ((x : L2I ℕ) : ℕ → ℂ)
        (((diagMax (oscSymbol κ) x : L2I ℕ) : ℕ → ℂ)) n
      + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ)
        (((diagMax (oscSymbol κ) x : L2I ℕ) : ℕ → ℂ)) n).im
      = -(4 * κ) * (amp κ n
        * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n) * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re) := by
    intro n
    simp only [crossA, crossB, diagMax_coe, oscSymbol_step]
    simp [Complex.add_im, Complex.mul_im, Complex.mul_re]
    ring
  have hIm' : HasSum (fun n => -(4 * κ) * (amp κ n
      * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n) * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re))
      (inner ℂ (nsH κ hκ x : L2I ℕ) (diagMax (oscSymbol κ) x : L2I ℕ) : ℂ).im := by
    refine hIm.congr_fun ?_
    intro n
    exact (hpt n).symm
  have hres := hIm'.mul_left (-2)
  rw [commForm_eq]
  refine hres.congr_fun ?_
  intro n
  ring

/-- The weighted occupation series `w(n)|xₙ|²`, dominated by the quadratic form
of the comparison operator. -/
theorem summable_ampOcc (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    Summable (fun n => amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2) := by
  refine Summable.of_nonneg_of_le (fun n => mul_nonneg (amp_nonneg hκ n) (sq_nonneg _))
    (fun n => ?_) ((diagMax_hasSum_quadForm (oscSymbol κ) x).summable.mul_left (1 / 4 + κ / 2))
  nlinarith [amp_le_symbol hκ n, sq_nonneg ‖((x : L2I ℕ) : ℕ → ℂ) n‖]

theorem tsum_ampOcc_le (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    (∑' n, amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2)
      ≤ (1 / 4 + κ / 2) * quadForm (diagMax (oscSymbol κ)) x := by
  have hq := diagMax_hasSum_quadForm (oscSymbol κ) x
  refine le_trans (Summable.tsum_le_tsum (fun n => ?_) (summable_ampOcc hκ x)
    (hq.summable.mul_left (1 / 4 + κ / 2))) ?_
  · nlinarith [amp_le_symbol hκ n, sq_nonneg ‖((x : L2I ℕ) : ℕ → ℂ) n‖]
  · exact le_of_eq (hq.mul_left (1 / 4 + κ / 2)).tsum_eq

/-- A series bound gives a bound on the sum. -/
theorem abs_le_of_hasSum {f g : ℕ → ℝ} {S T : ℝ} (hf : HasSum f S) (hg : HasSum g T)
    (h : ∀ n, |f n| ≤ g n) : |S| ≤ T := by
  refine abs_le.mpr ⟨?_, hasSum_le (fun n => le_trans (le_abs_self _) (h n)) hf hg⟩
  have hneg : HasSum (fun n => -g n) (-T) := hg.neg
  have := hasSum_le (fun n => by linarith [neg_abs_le (f n), h n] : ∀ n, -g n ≤ f n) hneg hf
  linarith

/-- **The second Faris–Lavine inequality for the Navier–Stokes Hamiltonian**:
`|⟪x, i[H,N]x⟫| ≤ (2κ + 4κ²) ⟪x, Nx⟫`.  Although `[H, N] ≠ 0`, the cross terms it
produces are dominated by the sum of the squares `π² + V² + I = N`, by
`2ab ≤ a² + b²`. -/
theorem nsH_commForm_bound (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    |commForm (nsH κ hκ) (diagMax (oscSymbol κ)) x|
      ≤ (2 * κ + 4 * κ ^ 2) * quadForm (diagMax (oscSymbol κ)) x := by
  have hus := summable_ampOcc hκ x
  have hutail : Summable (fun n => amp κ (n + 2) * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2) :=
    (summable_nat_add_iff 2).mpr hus
  have hbound : HasSum (fun n => 4 * κ * (amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2
      + amp κ (n + 2) * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2))
      (4 * κ * ((∑' n, amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2)
        + ∑' n, amp κ (n + 2) * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2)) :=
    (hus.hasSum.add hutail.hasSum).mul_left (4 * κ)
  have hptle : ∀ n, |8 * κ * (amp κ n * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n)
        * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re)|
      ≤ 4 * κ * (amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2
        + amp κ (n + 2) * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2) := by
    intro n
    have hamp : 0 ≤ amp κ n := amp_nonneg hκ n
    have hre : |((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n)
        * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re|
        ≤ ‖((x : L2I ℕ) : ℕ → ℂ) n‖ * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ := by
      refine le_trans (Complex.abs_re_le_norm _) ?_
      rw [norm_mul, RCLike.norm_conj]
    have habs : |8 * κ * (amp κ n * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n)
          * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re)|
        = 8 * κ * amp κ n * |((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n)
          * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re| := by
      rw [show (8 : ℝ) * κ * (amp κ n * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n)
          * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re)
          = (8 * κ * amp κ n) * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n)
            * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re from by ring, abs_mul,
        abs_of_nonneg (by positivity : (0 : ℝ) ≤ 8 * κ * amp κ n)]
    have h1 : 8 * κ * amp κ n * |((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n)
          * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re|
        ≤ 8 * κ * amp κ n * (‖((x : L2I ℕ) : ℕ → ℂ) n‖ * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖) :=
      mul_le_mul_of_nonneg_left hre (by positivity)
    have hkey : 8 * κ * amp κ n * (‖((x : L2I ℕ) : ℕ → ℂ) n‖ * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖)
        ≤ 4 * κ * (amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2
          + amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2) := by
      have h2ab : 2 * (‖((x : L2I ℕ) : ℕ → ℂ) n‖ * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖)
          ≤ ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2 + ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2 := by
        nlinarith [sq_nonneg (‖((x : L2I ℕ) : ℕ → ℂ) n‖ - ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖)]
      have := mul_le_mul_of_nonneg_left h2ab
        (show (0 : ℝ) ≤ 4 * κ * amp κ n by positivity)
      linarith [this]
    have hmono : 4 * κ * (amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2)
        ≤ 4 * κ * (amp κ (n + 2) * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2) :=
      mul_le_mul_of_nonneg_left
        (mul_le_mul_of_nonneg_right (amp_le_amp_add_two hκ n) (sq_nonneg _)) (by positivity)
    rw [habs]
    linarith
  have habs := abs_le_of_hasSum (hasSum_commForm hκ x) hbound hptle
  have htail : (∑' n, amp κ (n + 2) * ‖((x : L2I ℕ) : ℕ → ℂ) (n + 2)‖ ^ 2)
      ≤ ∑' n, amp κ n * ‖((x : L2I ℕ) : ℕ → ℂ) n‖ ^ 2 :=
    tsum_shift_le hus (fun n => mul_nonneg (amp_nonneg hκ n) (sq_nonneg _))
  have hU := tsum_ampOcc_le hκ x
  have hqf : 0 ≤ quadForm (diagMax (oscSymbol κ)) x :=
    diagMax_quadForm_nonneg _ (oscSymbol_nonneg hκ) x
  refine le_trans habs ?_
  nlinarith [hU, htail, hκ]

/-! ## Essential self-adjointness, with no hypothesis left -/

/-- **The Navier–Stokes fiber Hamiltonian is essentially self-adjoint on the
finite-mode core.**  Both Faris–Lavine inequalities are theorems here
(`nsH_relative_bound`, `nsH_commForm_bound`); the criterion itself is
`BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine` and the
Ikebe–Kato-type input is
`BookProof.NavierStokesFlow.IkebeKato.essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds`.
Nothing is assumed. -/
theorem nsH_essentiallySelfAdjointOn_core (hκ : 0 ≤ κ) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((nsH κ hκ).comp (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol κ)))) :=
  essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds (oscSymbol κ)
    (oscSymbol_nonneg hκ) (nsH κ hκ) (1 / 2) (2 * κ ^ 2) (2 * κ + 4 * κ ^ 2)
    (nsH_symmetricOn hκ) (by positivity) (nsH_relative_bound hκ) (nsH_commForm_bound hκ)

/-! ## The commutator is genuinely non-zero

The bound `± i[H, N] ≤ c N` is not the trivial statement `[H, N] = 0`: the
momentum and the advection field do not commute, and already the two-level state
`e₀ + e₂` sees the commutator. -/

/-- The test state `e₀ + e₂`. -/
noncomputable def testState (κ : ℝ) : maxDom (oscSymbol κ) :=
  ⟨(lp.single 2 0 (1 : ℂ) + lp.single 2 2 (1 : ℂ) : L2I ℕ),
    finiteModes_le_maxDom _ (Submodule.add_mem _ (lpSingle_mem_lpFiniteModes 0 (1 : ℂ))
      (lpSingle_mem_lpFiniteModes 2 (1 : ℂ)))⟩

theorem testState_coe (κ : ℝ) (n : ℕ) :
    ((testState κ : L2I ℕ) : ℕ → ℂ) n = if n = 0 then 1 else if n = 2 then 1 else 0 := by
  simp only [testState, lp.coeFn_add, Pi.add_apply, lp.single_apply, Pi.single_apply]
  by_cases h0 : n = 0
  · subst h0; norm_num
  · by_cases h2 : n = 2
    · subst h2; norm_num
    · simp [h0, h2]

/-- **`i[H, N] ≠ 0`.**  On `e₀ + e₂` the commutator form equals `8κ w(0) > 0` for
`κ > 0`: the Faris–Lavine bound is dominating a genuinely non-zero commutator, not
a vanishing one. -/
theorem commForm_testState (hκ : 0 ≤ κ) :
    commForm (nsH κ hκ) (diagMax (oscSymbol κ)) (testState κ) = 8 * κ * amp κ 0 := by
  have hcs := hasSum_commForm hκ (testState κ)
  have hsingle : HasSum (fun n => 8 * κ * (amp κ n
      * ((starRingEnd ℂ) (((testState κ : L2I ℕ) : ℕ → ℂ) n)
        * ((testState κ : L2I ℕ) : ℕ → ℂ) (n + 2)).re)) (8 * κ * (amp κ 0
      * ((starRingEnd ℂ) (((testState κ : L2I ℕ) : ℕ → ℂ) 0)
        * ((testState κ : L2I ℕ) : ℕ → ℂ) (0 + 2)).re)) := by
    refine hasSum_single 0 fun n hn => ?_
    rcases Nat.lt_or_ge n 3 with h | h
    · interval_cases n
      · exact absurd rfl hn
      · simp [testState_coe]
      · simp [testState_coe]
    · have h1 : ((testState κ : L2I ℕ) : ℕ → ℂ) n = 0 := by
        rw [testState_coe]
        have : n ≠ 0 := by omega
        have : n ≠ 2 := by omega
        simp [*]
      simp [h1]
  rw [hcs.unique hsingle]
  simp [testState_coe]

/-- For a positive strain rate the commutator form is strictly positive at
`e₀ + e₂`; in particular `[H, N] ≠ 0`. -/
theorem commForm_ne_zero_of_pos (hκ : 0 < κ) :
    commForm (nsH κ (le_of_lt hκ)) (diagMax (oscSymbol κ)) (testState κ) ≠ 0 := by
  rw [commForm_testState (le_of_lt hκ)]
  have hamp : 0 < amp κ 0 := by
    have : (0 : ℝ) < Real.sqrt ((0 + 1) * (0 + 2)) := by
      rw [Real.sqrt_pos]; norm_num
    simp only [amp]
    push_cast
    positivity
  positivity

end Domain

end HermiteFarisLavine

end BookProof.NavierStokesFlow
