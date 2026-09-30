import Definitions.Def_ChapterNavierStokesSecondQuant
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Mathlib

import Mathlib

/-!
# The Faris–Lavine data on the Fock space

This module puts the two previous ones together.  `ChapterNavierStokesSecondQuant`
lifts essential self-adjointness from the sectors of the Fock space
`⨁ₘ Sₘ` to the finite-particle domain, and `ChapterNavierStokesFarisLavineLift`
analyses what happens to the two Faris–Lavine inequalities when the
one-particle operators are summed over the particles of a sector.  Here the
inequalities are transported to the Fock space itself:

* `fockOp_isSymmetricDom` — a sector-wise symmetric operator is symmetric on the
  finite-particle domain;
* `fockOp_norm_le_of_sectors` — the relative bound `‖Ĥψ‖ ≤ c₁‖N̂ψ‖` holds on the
  Fock space as soon as it holds in every sector with the same constant;
* `fockOp_norm_inner_le_of_sectors` — likewise for the form bound
  `|⟪ψ, Âψ⟫| ≤ c₂ Re⟪ψ, N̂ψ⟫`, which applied to `Â = [Ĥ, N̂]` is the
  Faris–Lavine commutator bound;
* `fockOp_commDom` — the commutator of two second quantizations is the second
  quantization of the sector-wise commutators, so the previous item does apply
  to it;
* `fockOp_hasZeroDeficiencyOn_of_farisLavine` — the assembled statement: given
  the Faris–Lavine criterion (as a named hypothesis, exactly as elsewhere in this
  project — it is never an `axiom`), sector-wise symmetry, and the two
  sector-wise inequalities, the second-quantized Hamiltonian has vanishing
  adjoint deficiency on the finite-particle domain of the Fock space.

`fockComparison_hasZeroDeficiencyOn` records the unconditional half in a
concrete case: the second quantization of the one-particle comparison operator
`n = ∑πᵢ² + ∑Vᵢ² + I` of the fiber momentum representation is essentially
self-adjoint on the finite-particle domain of the corresponding Fock space, and
that domain is a proper subspace.

## Scope

Essential self-adjointness of the continuum Navier–Stokes Hamiltonian is **not**
claimed.  The Faris–Lavine criterion is an input here, and its two inequalities
are proved here only to *lift*: whether they hold for the one-particle
Navier–Stokes operator is not settled in this project.

**Update.**  The named hypothesis `farisLavine` of
`fockOp_hasZeroDeficiencyOn_of_farisLavine` is stated in the *unrestricted* form
(relative bound plus commutator bound, with no positivity of `N` and no
surjectivity of `N + 1`), and that form of the criterion is refutable —
`BookProof.FarisLavine.not_farisLavine_criterion_of_relative_bound`.  The
hypothesis-free replacement is in
`BookProof.ChapterNavierStokesIkebeKato` and
`BookProof.ChapterNavierStokesMomentumEsa`: there the comparison operator is
taken on its maximal domain, where positivity, surjectivity of `N + 1` and the
core property of the finite-mode states are all *proved*, and the criterion
itself is the theorem
`BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow
/-! ## Cross-chapter definitions from `BookProof.FarisLavine` -/
theorem not_farisLavine_criterion_of_relative_bound :
    ¬ (∀ (D' : Submodule ℂ L2N) (H' N' : D' →ₗ[ℂ] D') (a b : ℝ),
        Dense (D' : Set L2N) →
        (∀ x y : D', (inner ℂ (H' x : L2N) (y : L2N) : ℂ) = inner ℂ (x : L2N) (H' y : L2N)) →
        (∀ v : D', ‖(H' v : L2N)‖ ≤ a * ‖(N' v : L2N)‖) →
        (∀ v : D', ‖(inner ℂ (v : L2N) ((H' (N' v) : L2N) - (N' (H' v) : L2N)) : ℂ)‖
          ≤ b * ‖(inner ℂ (v : L2N) (N' v : L2N) : ℂ)‖) →
        HasZeroDeficiencyOn D' H') := by
  intro hcrit
  refine jacobiOp_not_hasZeroDeficiencyOn ?_
  refine hcrit (lpFiniteModes ℕ) jacobiOp jacobiOp 1 0 lpFiniteModes_dense jacobiOp_symmetric
    (fun v => by simp) (fun v => by simp)

/-! ## An unbounded application: multiplication operators on `ℓ²(ℕ)`

The multiplication operator by an arbitrary real sequence `lam`, on its maximal
domain, satisfies the hypotheses of Theorem 1 with `N = |lam|` and `c = 0`: the
two operators commute, so the commutator form vanishes identically, and `N + 1`
is surjective because `1 + |lam n| ≥ 1`.  Hence it is essentially self-adjoint —
an unbounded instance of the criterion. -/

section Multiplication

open scoped ENNReal

/-- The Hilbert space `ℓ²(ℕ)`. -/
abbrev L2Nat := lp (fun _ : ℕ => ℂ) 2

/-- Coefficientwise multiplication by a real symbol. -/
def mulSymbolFun (s : ℕ → ℝ) (f : ℕ → ℂ) : ℕ → ℂ := fun n => (s n : ℂ) * f n

theorem memLpTwo_of_norm_le {f g : ℕ → ℂ} (hg : Memℓp g 2) (h : ∀ n, ‖f n‖ ≤ ‖g n‖) :
    Memℓp f 2 := by
  rw [memℓp_gen_iff (by norm_num)] at hg ⊢
  refine Summable.of_nonneg_of_le (fun n => by positivity) (fun n => ?_) hg
  gcongr
  exact h n

/-- The maximal domain of multiplication by `lam`. -/
def mulSymbolDomain (lam : ℕ → ℝ) : Submodule ℂ L2Nat where
  carrier := {f : L2Nat | Memℓp (mulSymbolFun lam ((f : L2Nat) : ℕ → ℂ)) 2}
  add_mem' := by
    intro f g hf hg
    have heq : mulSymbolFun lam ((f + g : L2Nat) : ℕ → ℂ)
        = mulSymbolFun lam ((f : L2Nat) : ℕ → ℂ) + mulSymbolFun lam ((g : L2Nat) : ℕ → ℂ) := by
      funext n; simp [mulSymbolFun]; ring
    simp only [Set.mem_setOf_eq, heq]
    exact hf.add hg
  zero_mem' := by
    have heq : mulSymbolFun lam ((0 : L2Nat) : ℕ → ℂ) = 0 := by
      funext n; simp [mulSymbolFun]
    simp only [Set.mem_setOf_eq, heq]
    exact zero_memℓp
  smul_mem' := by
    intro c f hf
    have heq : mulSymbolFun lam ((c • f : L2Nat) : ℕ → ℂ)
        = c • mulSymbolFun lam ((f : L2Nat) : ℕ → ℂ) := by
      funext n; simp [mulSymbolFun]; ring
    simp only [Set.mem_setOf_eq, heq]
    exact hf.const_smul c

/-- Multiplication by a symbol `s` dominated by `lam`, on the maximal domain of
`lam`. -/
noncomputable def mulSymbolOp (lam s : ℕ → ℝ) (hs : ∀ n, |s n| ≤ |lam n|) :
    mulSymbolDomain lam →ₗ[ℂ] L2Nat where
  toFun f := ⟨mulSymbolFun s ((f : L2Nat) : ℕ → ℂ), by
    refine memLpTwo_of_norm_le f.2 fun n => ?_
    simp only [mulSymbolFun, norm_mul, Complex.norm_real, Real.norm_eq_abs]
    exact mul_le_mul_of_nonneg_right (hs n) (norm_nonneg _)⟩
  map_add' f g := by ext n; simp [mulSymbolFun]; ring
  map_smul' c f := by ext n; simp [mulSymbolFun]; ring

@[simp] theorem mulSymbolOp_coe (lam s : ℕ → ℝ) (hs : ∀ n, |s n| ≤ |lam n|)
    (f : mulSymbolDomain lam) :
    ((mulSymbolOp lam s hs f : L2Nat) : ℕ → ℂ) = mulSymbolFun s ((f : L2Nat) : ℕ → ℂ) := rfl

theorem abs_abs_le (lam : ℕ → ℝ) : ∀ n, |(|lam n|)| ≤ |lam n| := fun n => by simp

/-- The comparison operator `N = |lam|`. -/
noncomputable def mulComparison (lam : ℕ → ℝ) : mulSymbolDomain lam →ₗ[ℂ] L2Nat :=
  mulSymbolOp lam (fun n => |lam n|) (abs_abs_le lam)

/-- The operator itself, multiplication by `lam`. -/
noncomputable def mulHamiltonian (lam : ℕ → ℝ) : mulSymbolDomain lam →ₗ[ℂ] L2Nat :=
  mulSymbolOp lam lam (fun _ => le_rfl)

theorem conj_mul_ofReal (b : ℝ) (z : ℂ) :
    (b : ℂ) * z * (starRingEnd ℂ) z = ((b * Complex.normSq z : ℝ) : ℂ) := by
  rw [show (b : ℂ) * z * (starRingEnd ℂ) z = (b : ℂ) * ((starRingEnd ℂ) z * z) by ring,
    ← Complex.normSq_eq_conj_mul_self]
  push_cast
  ring

theorem conj_mul_ofReal₂ (a b : ℝ) (z : ℂ) :
    (b : ℂ) * z * (starRingEnd ℂ) ((a : ℂ) * z) = ((a * b * Complex.normSq z : ℝ) : ℂ) := by
  rw [map_mul, Complex.conj_ofReal,
    show (b : ℂ) * z * ((a : ℂ) * (starRingEnd ℂ) z)
      = (a : ℂ) * (b : ℂ) * ((starRingEnd ℂ) z * z) by ring,
    ← Complex.normSq_eq_conj_mul_self]
  push_cast
  ring

/-- Multiplication by a real symbol is symmetric. -/
theorem mulSymbolOp_symmetric (lam s : ℕ → ℝ) (hs : ∀ n, |s n| ≤ |lam n|) :
    SymmetricOn (mulSymbolDomain lam) (mulSymbolOp lam s hs) := by
  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun n => ?_
  simp only [mulSymbolOp_coe, mulSymbolFun, RCLike.inner_apply, map_mul, Complex.conj_ofReal]
  ring

/-- The comparison operator is positive. -/
theorem mulComparison_nonneg (lam : ℕ → ℝ) (x : mulSymbolDomain lam) :
    0 ≤ quadForm (mulComparison lam) x := by
  rw [quadForm, lp.inner_eq_tsum, Complex.re_tsum (lp.summable_inner _ _)]
  refine tsum_nonneg fun n => ?_
  have hterm : (inner ℂ (((x : L2Nat) : ℕ → ℂ) n)
      (((mulComparison lam x : L2Nat) : ℕ → ℂ) n) : ℂ)
      = ((|lam n| * Complex.normSq (((x : L2Nat) : ℕ → ℂ) n) : ℝ) : ℂ) := by
    simpa only [mulComparison, mulSymbolOp_coe, mulSymbolFun, RCLike.inner_apply] using
      conj_mul_ofReal (|lam n|) (((x : L2Nat) : ℕ → ℂ) n)
  rw [hterm, Complex.ofReal_re]
  exact mul_nonneg (abs_nonneg _) (Complex.normSq_nonneg _)

/-- The two symbols commute, so the commutator form vanishes identically. -/
theorem mulHamiltonian_commForm (lam : ℕ → ℝ) (x : mulSymbolDomain lam) :
    commForm (mulHamiltonian lam) (mulComparison lam) x = 0 := by
  rw [commForm_eq, lp.inner_eq_tsum, Complex.im_tsum (lp.summable_inner _ _)]
  have hterm : ∀ n : ℕ, (inner ℂ (((mulHamiltonian lam x : L2Nat) : ℕ → ℂ) n)
      (((mulComparison lam x : L2Nat) : ℕ → ℂ) n) : ℂ).im = 0 := by
    intro n
    have hn : (inner ℂ (((mulHamiltonian lam x : L2Nat) : ℕ → ℂ) n)
        (((mulComparison lam x : L2Nat) : ℕ → ℂ) n) : ℂ)
        = ((lam n * |lam n| * Complex.normSq (((x : L2Nat) : ℕ → ℂ) n) : ℝ) : ℂ) := by
      simpa only [mulHamiltonian, mulComparison, mulSymbolOp_coe, mulSymbolFun,
        RCLike.inner_apply] using conj_mul_ofReal₂ (lam n) (|lam n|) (((x : L2Nat) : ℕ → ℂ) n)
    rw [hn, Complex.ofReal_im]
  have hsum : ∑' n : ℕ, (inner ℂ (((mulHamiltonian lam x : L2Nat) : ℕ → ℂ) n)
      (((mulComparison lam x : L2Nat) : ℕ → ℂ) n) : ℂ).im = 0 := by
    calc ∑' n : ℕ, (inner ℂ (((mulHamiltonian lam x : L2Nat) : ℕ → ℂ) n)
          (((mulComparison lam x : L2Nat) : ℕ → ℂ) n) : ℂ).im
        = ∑' _ : ℕ, (0 : ℝ) := tsum_congr hterm
      _ = 0 := tsum_zero
  rw [hsum]
  ring

/-- `N + 1` maps the maximal domain onto `ℓ²(ℕ)`: the resolvent at `-1` is
multiplication by `(1 + |lam n|)⁻¹`. -/
theorem mulComparison_surjective (lam : ℕ → ℝ) (g : L2Nat) :
    ∃ x : mulSymbolDomain lam, (mulComparison lam x : L2Nat) + (x : L2Nat) = g := by
  have hpos : ∀ n, (0 : ℝ) < 1 + |lam n| := fun n => by positivity
  set fn : ℕ → ℂ := fun n => ((g : L2Nat) : ℕ → ℂ) n / ((1 + |lam n| : ℝ) : ℂ) with hfn
  have hle : ∀ n, ‖fn n‖ ≤ ‖((g : L2Nat) : ℕ → ℂ) n‖ := by
    intro n
    rw [hfn]
    simp only [norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (hpos n)]
    rw [div_le_iff₀ (hpos n)]
    nlinarith [norm_nonneg (((g : L2Nat) : ℕ → ℂ) n), abs_nonneg (lam n)]
  have hmem : Memℓp fn 2 := memLpTwo_of_norm_le g.2 hle
  have hdom : (⟨fn, hmem⟩ : L2Nat) ∈ mulSymbolDomain lam := by
    refine memLpTwo_of_norm_le g.2 fun n => ?_
    have hval : ‖mulSymbolFun lam fn n‖
        = |lam n| / (1 + |lam n|) * ‖((g : L2Nat) : ℕ → ℂ) n‖ := by
      simp only [mulSymbolFun, hfn, norm_mul, norm_div, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos (hpos n)]
      ring
    rw [show ((⟨fn, hmem⟩ : L2Nat) : ℕ → ℂ) = fn from rfl, hval]
    have hfrac : |lam n| / (1 + |lam n|) ≤ 1 := by
      rw [div_le_one (hpos n)]
      linarith
    nlinarith [norm_nonneg (((g : L2Nat) : ℕ → ℂ) n), abs_nonneg (lam n)]
  refine ⟨⟨⟨fn, hmem⟩, hdom⟩, ?_⟩
  ext n
  simp only [lp.coeFn_add, Pi.add_apply, mulComparison, mulSymbolOp_coe, mulSymbolFun]
  have hne : ((1 + |lam n| : ℝ) : ℂ) ≠ 0 := by exact_mod_cast ne_of_gt (hpos n)
  change ((|lam n| : ℝ) : ℂ) * fn n + fn n = ((g : L2Nat) : ℕ → ℂ) n
  rw [hfn]
  field_simp
  push_cast
  ring

/-- **An unbounded application of Theorem 1.**  Multiplication by an arbitrary
real sequence `lam` is essentially self-adjoint on its maximal domain in
`ℓ²(ℕ)`: take `N = |lam|`, for which the commutator form vanishes (`c = 0`) and
`N + 1` is invertible. -/
theorem mulHamiltonian_essentiallySelfAdjoint (lam : ℕ → ℝ) :
    EssentiallySelfAdjointOn (mulSymbolDomain lam) (mulHamiltonian lam) :=
  essentiallySelfAdjointOn_of_farisLavine (mulHamiltonian lam) (mulComparison lam) 0
    (mulSymbolOp_symmetric lam lam (fun _ => le_rfl))
    (mulSymbolOp_symmetric lam (fun n => |lam n|) (abs_abs_le lam)) le_rfl
    (mulComparison_nonneg lam) (mulComparison_surjective lam)
    (fun x => by rw [mulHamiltonian_commForm lam x]; simp)

/-- The basis state `e n`, which lies in every maximal domain. -/
noncomputable def mulBasis (lam : ℕ → ℝ) (n : ℕ) : mulSymbolDomain lam :=
  ⟨lp.single 2 n 1, by
    have hval : mulSymbolFun lam ((lp.single 2 n (1 : ℂ) : L2Nat) : ℕ → ℂ)
        = (lam n : ℂ) • ((lp.single 2 n (1 : ℂ) : L2Nat) : ℕ → ℂ) := by
      funext m
      by_cases hmn : m = n
      · subst hmn; simp [mulSymbolFun, lp.single_apply]
      · simp [mulSymbolFun, lp.single_apply, Pi.single_eq_of_ne hmn]
    change Memℓp (mulSymbolFun lam ((lp.single 2 n (1 : ℂ) : L2Nat) : ℕ → ℂ)) 2
    rw [hval]
    exact (lp.memℓp _).const_smul _⟩

/-- **The operator really is unbounded** when its symbol is. -/
theorem mulHamiltonian_not_bounded (lam : ℕ → ℝ) (hlam : ∀ C : ℝ, ∃ n, C < |lam n|) :
    ¬ ∃ C : ℝ, ∀ f : mulSymbolDomain lam, ‖mulHamiltonian lam f‖ ≤ C * ‖(f : L2Nat)‖ := by
  rintro ⟨C, hC⟩
  obtain ⟨n, hn⟩ := hlam C
  have hb := hC (mulBasis lam n)
  have hval : (mulHamiltonian lam (mulBasis lam n) : L2Nat)
      = (lam n : ℂ) • lp.single 2 n (1 : ℂ) := by
    ext m
    by_cases hmn : m = n
    · subst hmn
      simp [mulHamiltonian, mulBasis, mulSymbolFun, lp.single_apply]
    · simp [mulHamiltonian, mulBasis, mulSymbolFun, lp.single_apply, Pi.single_eq_of_ne hmn]
  have hnorm : ‖(lp.single 2 n (1 : ℂ) : L2Nat)‖ = 1 := by
    simp
  rw [hval, norm_smul] at hb
  have hb' : |lam n| ≤ C := by
    have hcoe : ‖(mulBasis lam n : L2Nat)‖ = 1 := hnorm
    rw [hcoe] at hb
    simpa [hnorm] using hb
  exact absurd hn (not_lt.mpr hb')

end Multiplication

/-! ## Discharging the named hypothesis of the Navier–Stokes chapter

`BookProof.ChapterNavierStokesFlow` carries essential self-adjointness on a dense
domain in its own predicate `HasZeroDeficiencyOn`, and obtains it from a
Faris–Lavine criterion supplied as a *named hypothesis*.  The predicate is
literally the conjunction of the two deficiency conditions used here, so the
theorem proved above discharges that hypothesis — in the corrected form, with `N`
positive and `N + 1` surjective (the unrestricted relative-bound form being false
by `not_farisLavine_criterion_of_relative_bound`). -/

section NavierStokesTieIn

open BookProof.NavierStokesFlow

/-- The predicate `HasZeroDeficiencyOn` of the Navier–Stokes chapter is exactly
`EssentiallySelfAdjointOn` for the operator viewed as taking values in the whole
space. -/
theorem essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
    (D : Submodule ℂ F) (H : D →ₗ[ℂ] D) :
    EssentiallySelfAdjointOn D (D.subtype.comp H) ↔ HasZeroDeficiencyOn D H := by
  have key : ∀ (w : F) (z : ℂ),
      (∀ v : D, (inner ℂ ((D.subtype.comp H) v) w : ℂ) = z * inner ℂ (v : F) w) ↔
        ∀ v : D, (inner ℂ (H v : F) w : ℂ) = inner ℂ (v : F) (z • w) := by
    intro w z
    constructor <;> intro h v
    · rw [inner_smul_right]; exact h v
    · have := h v; rwa [inner_smul_right] at this
  constructor
  · rintro ⟨h1, h2⟩
    refine ⟨fun w hw => h1 w ((key w Complex.I).2 hw), fun w hw => h2 w ((key w (-Complex.I)).2 ?_)⟩
    intro v
    rw [neg_smul]
    exact hw v
  · rintro ⟨h1, h2⟩
    refine ⟨fun w hw => h1 w ((key w Complex.I).1 hw), fun w hw => h2 w ?_⟩
    intro v
    rw [← neg_smul]
    exact (key w (-Complex.I)).1 hw v

/-- **Faris–Lavine for the Navier–Stokes chapter's predicate.**  With `H` and the
positive comparison operator `N` given on a common dense domain `D` and mapping
`D` into itself, the commutator bound `± i[H, N] ≤ c N` gives vanishing adjoint
deficiency in the sense of `BookProof.NavierStokesFlow.HasZeroDeficiencyOn`. -/
theorem hasZeroDeficiencyOn_of_farisLavine [CompleteSpace F]
    (D : Submodule ℂ F) (H N : D →ₗ[ℂ] D) (c : ℝ)
    (hH : SymmetricOn D (D.subtype.comp H)) (hN : SymmetricOn D (D.subtype.comp N))
    (hc : 0 ≤ c)
    (hNpos : ∀ x : D, 0 ≤ quadForm (D.subtype.comp N) x)
    (hNsurj : ∀ f : F, ∃ x : D, (N x : F) + (x : F) = f)
    (hcomm : ∀ x : D, |commForm (D.subtype.comp H) (D.subtype.comp N) x|
      ≤ c * quadForm (D.subtype.comp N) x) :
    HasZeroDeficiencyOn D H :=
  (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn D H).1
    (essentiallySelfAdjointOn_of_farisLavine (D.subtype.comp H) (D.subtype.comp N) c
      hH hN hc hNpos hNsurj hcomm)

end NavierStokesTieIn

namespace SecondQuant

open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

/-! ## Algebra of second quantizations -/







/-! ## Symmetry -/



/-! ## The relative bound -/





/-! ## The form bound -/





/-! ## The assembled Faris–Lavine statement on the Fock space -/



/-! ## A concrete Fock space over the fiber momentum representation -/

section ConcreteFock

open FarisLavineLift LpNat DiagonalEsa

/-- The sector spaces of the concrete example: every sector is a copy of the
fiber space `ℓ²(ℕ)` of the momentum representation. -/
abbrev fiberSector : ℕ → Type := fun _ => L2N

/-- The sector domains: the finite-mode core of each fiber, the analogue of
`C_c^∞`. -/
noncomputable def fiberCore : ∀ m : ℕ, Submodule ℂ (fiberSector m) := fun _ => lpFiniteModes ℕ

/-- **The second quantization `N̂ = dΓ(n) + I` of the one-particle comparison
operator** `n = ∑πᵢ² + ∑Vᵢ² + I`, in the fiber momentum representation. -/
noncomputable def fockComparison (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    fockCore fiberCore →ₗ[ℂ] fockCore fiberCore :=
  fockOp (fun _ => (diagComparisonData d p q).comparison)









end ConcreteFock

end SecondQuant

end BookProof.NavierStokesFlow
