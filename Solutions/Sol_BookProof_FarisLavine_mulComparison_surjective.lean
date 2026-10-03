-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.mulComparison_surjective
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
 :=
  import Mathlib
  import BookProof.ChapterNavierStokesDeficiency
  import BookProof.ChapterFarisLavineCore
  
  /-!
  # Faris–Lavine: the concrete companions of the abstract criterion
  
  The abstract Faris–Lavine theory — `SymmetricOn`, `DeficiencyTrivialAt`,
  `EssentiallySelfAdjointOn`, `quadForm`, `commForm` and the criterion
  `essentiallySelfAdjointOn_of_farisLavine` — lives in
  `BookProof.ChapterFarisLavineCore`, which depends on Mathlib alone.  This module
  adds the parts that talk to the concrete operators of the Navier–Stokes chapters:
  the refutation of the criterion without positivity of `N`, the multiplication
  operators on `ℓ²(ℕ)`, and the tie-in with
  `BookProof.NavierStokesFlow.HasZeroDeficiencyOn`.
  -/
  
  namespace BookProof.FarisLavine
  
  variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  variable {D : Submodule ℂ F}
  
  
  /-! ## The hypotheses cannot be weakened to a mere relative bound
  
  The Navier–Stokes chapters of this project carry the Faris–Lavine criterion as a
  named hypothesis in the form: *`H` symmetric on a dense domain, `‖H v‖ ≤ a ‖N v‖`,
  and `|⟪v, [H, N] v⟫| ≤ b |⟪v, N v⟫|` imply vanishing adjoint deficiency*, with no
  positivity and no self-adjointness required of `N`.  That form of the statement
  is **false**, and the theorem below refutes it: for the limit-circle Jacobi
  operator of `BookProof.ChapterNavierStokesDeficiency` the choice `N = H` verifies
  both inequalities (with `a = 1`, `b = 0`) while essential self-adjointness fails.
  The positivity of `N` and the surjectivity of `N + 1` in
  `essentiallySelfAdjointOn_of_farisLavine` are therefore not decorative. -/
  
  open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
    BookProof.NavierStokesFlow.JacobiDeficiency in
  /-- **The criterion without positivity of `N` is false.**  Witness: `H = N =` the
  limit-circle Jacobi operator on the finitely supported states of `ℓ²(ℕ)`. -/
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
  noncomputable abbrev L2Nat := lp (fun _ : ℕ => ℂ) 2
  
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
    map_add' f g := by
      ext n
      simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply, mulSymbolFun]
      ring
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
    change ((|lam n| : ℝ) : ℂ) * fn n + fn
