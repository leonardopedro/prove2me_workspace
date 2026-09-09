import Mathlib
import BookProof.ChapterQuantumGravityDensitized
import BookProof.ChapterStoneBridge

/-!
# The R + αR² (Starobinsky) potentials, and the flow of the regularized conformal mode

Plan item **A5** (`CONSOLIDATED_PLAN.md` §10.5), steps 1 and — at the mode level — 3/4.

The `f(R) = (M²/2)R + αR²` extension of the Einstein–Hilbert action is the one whose extra
term *regularizes* the conformal mode: the linear `−(M²/2)R_c` term, whose negative
conformal-mode gradient energy leaves pure general relativity unbounded below, is turned by
the positive `αR_c²` into a parabola bounded below by `−M⁴/(16α)`.

## What is proved

**1. The ghost-free scalar–tensor form.**  With `ψ = 1 + 4αR/M²` and
`U(ψ) = (M⁴/16α)(ψ − 1)²`, `fR_eq_scalarTensor` is the identity
`f(R) = (M²/2)ψR − U(ψ)`: `R + αR²` gravity is a *second-order* scalar–tensor theory.

**2. The Einstein-frame scalaron potential.**  `starobinskyV M α φ = (M⁴/16α)(1 −
e^{−√(2/3)φ/M})²` is manifestly a square, hence
* `starobinskyV_nonneg` — non-negative, the strongest form of the correct (elliptic) sign;
* `starobinskyV_zero` — vanishing at `φ = 0`, the flat Minkowski vacuum;
* `starobinskyV_tendsto_plateau` — the large-field plateau `M⁴/(16α)`;
* `starobinskyV_tendsto_atBot_atTop` — the exponential wall as `φ → −∞`.

**3. The conformal-mode potential and its regularization.**
* `confV_completed_square` — `V₃(R_c) = α(R_c − M²/(4α))² − M⁴/(16α)`;
* `confV_ge`, `confV_bddBelow` — bounded below by `−M⁴/(16α)` for `α > 0`;
* `confV_zero_alpha_tendsto_atBot` — and *not* bounded below when `α = 0`: this is exactly
  what the `αR²` term buys.

**4. The mode Hamiltonian, its essential self-adjointness and its flow.**  In the
densitized variables the gravity fiber operator is multiplication by the mode symbol
`(1/16)a_k² − (1/24)b_k² + V_k` (`BookProof.ChapterQuantumGravityDensitized`); with the
Starobinsky conformal-mode potential `V_k = V₃(R_c k)` this is `qgR2ModeHamiltonian`, and
* `qgR2Mode_potential_ge` — its potential part is bounded below by `−M⁴/(16α)`, uniformly
  in the mode, which is the regularization at the level of the operator;
* `qgR2Mode_esa` — it is essentially self-adjoint on its maximal domain (deficiency trivial
  at every non-real `z`, `qgR2Mode_deficiencyTrivialAt`);
* `mulSymbolDomain_dense` — that domain is dense (it contains the finitely supported
  states);
* **`qgR2_stone_flow`** — hence, through the Stone bridge, it generates the complete unitary
  group `e^{−itH}` solving the Schrödinger equation on its domain: the first continuous flow
  for the gauge-fixed `R + αR²` gravity Hamiltonian in this development, the QG analogue of
  `ns_stone_flow` / `ym_fock_stone_flow`.

## Honest boundary

Unchanged from `CONSOLIDATED_PLAN.md` §10.3/§10.5.  The flow above is that of the
*mode* (Hermite-basis) realization, where the fiber operator is a multiplication operator;
the continuum `L²(ℝ⁸⁴)` statement with the full polynomial potential still needs the
Strichartz finite-speed / direct-integral input, and the gauge/BRST sector is outside the
statement.  No mass gap and no global existence is claimed.  The potentials formalized here
are the mathematics of the derivation, not the symbolic-algebra program that produced it.
-/

open Filter Topology

namespace BookProof.Starobinsky

open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

/-! ## 1. The `f(R)` function and its scalar–tensor form -/

/-- The Starobinsky Lagrangian function `f(R) = (M²/2)R + αR²`. -/
def fR (M alpha R : ℝ) : ℝ := M ^ 2 / 2 * R + alpha * R ^ 2

/-- The scalar-tensor field `ψ = 1 + 4αR/M²`. -/
def scalaron (M alpha R : ℝ) : ℝ := 1 + 4 * alpha * R / M ^ 2

/-- The scalar-tensor potential `U(ψ) = (M⁴/16α)(ψ − 1)²`. -/
def Upot (M alpha psi : ℝ) : ℝ := M ^ 4 / (16 * alpha) * (psi - 1) ^ 2

/-- **The ghost-free scalar–tensor equivalence**: `f(R) = (M²/2)ψR − U(ψ)` with
`ψ = 1 + 4αR/M²`.  `R + αR²` gravity is a second-order scalar–tensor theory, so it carries
no Ostrogradsky ghost. -/
theorem fR_eq_scalarTensor {M alpha : ℝ} (hM : M ≠ 0) (halpha : alpha ≠ 0) (R : ℝ) :
    fR M alpha R
      = M ^ 2 / 2 * scalaron M alpha R * R - Upot M alpha (scalaron M alpha R) := by
  have hM2 : M ^ 2 ≠ 0 := pow_ne_zero 2 hM
  simp only [fR, scalaron, Upot]
  field_simp
  ring

/-! ## 2. The Einstein-frame scalaron potential -/

/-- The Einstein-frame scalaron potential
`V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²`. -/
def starobinskyV (M alpha phi : ℝ) : ℝ :=
  M ^ 4 / (16 * alpha) * (1 - Real.exp (-(Real.sqrt (2 / 3)) * phi / M)) ^ 2

/-- **The scalaron potential is non-negative** — it is a square times a positive constant.
This is the strongest form of the sign condition the elliptic essential-self-adjointness
arguments need. -/
theorem starobinskyV_nonneg {M alpha : ℝ} (halpha : 0 < alpha) (phi : ℝ) :
    0 ≤ starobinskyV M alpha phi := by
  have h16 : (0 : ℝ) < 16 * alpha := by linarith
  have h1 : 0 ≤ M ^ 4 / (16 * alpha) := div_nonneg (by positivity) h16.le
  exact mul_nonneg h1 (sq_nonneg _)

/-- **The Minkowski vacuum**: the scalaron potential vanishes at `φ = 0`. -/
@[simp] theorem starobinskyV_zero (M alpha : ℝ) : starobinskyV M alpha 0 = 0 := by
  simp [starobinskyV]

/-- **The large-field plateau**: `V(φ) → M⁴/(16α)` as `φ → +∞`, the inflationary plateau of
the Starobinsky model. -/
theorem starobinskyV_tendsto_plateau {M alpha : ℝ} (hM : 0 < M) :
    Tendsto (fun phi => starobinskyV M alpha phi) atTop (𝓝 (M ^ 4 / (16 * alpha))) := by
  have hc : 0 < Real.sqrt (2 / 3) / M := div_pos (Real.sqrt_pos.mpr (by norm_num)) hM
  have hlin : Tendsto (fun phi : ℝ => -(Real.sqrt (2 / 3)) * phi / M) atTop atBot := by
    have h : Tendsto (fun phi : ℝ => -(Real.sqrt (2 / 3) / M) * phi) atTop atBot :=
      Filter.Tendsto.const_mul_atTop_of_neg (by linarith : -(Real.sqrt (2 / 3) / M) < 0)
        tendsto_id
    refine h.congr fun phi => ?_
    field_simp
  have hexp : Tendsto (fun phi : ℝ => Real.exp (-(Real.sqrt (2 / 3)) * phi / M)) atTop
      (𝓝 0) := Real.tendsto_exp_atBot.comp hlin
  have h2 := ((tendsto_const_nhds (x := (1 : ℝ)) (f := atTop)).sub hexp).pow 2
  simpa [starobinskyV] using h2.const_mul (M ^ 4 / (16 * alpha))

/-- **The exponential wall**: `V(φ) → +∞` as `φ → −∞`. -/
theorem starobinskyV_tendsto_atBot_atTop {M alpha : ℝ} (hM : 0 < M) (halpha : 0 < alpha) :
    Tendsto (fun phi => starobinskyV M alpha phi) atBot atTop := by
  have hcpos : 0 < Real.sqrt (2 / 3) / M := div_pos (Real.sqrt_pos.mpr (by norm_num)) hM
  have hlin : Tendsto (fun phi : ℝ => -(Real.sqrt (2 / 3)) * phi / M) atBot atTop := by
    have h : Tendsto (fun phi : ℝ => -(Real.sqrt (2 / 3) / M) * phi) atBot atTop :=
      Filter.Tendsto.const_mul_atBot_of_neg (by linarith : -(Real.sqrt (2 / 3) / M) < 0)
        tendsto_id
    refine h.congr fun phi => ?_
    field_simp
  have hexp : Tendsto (fun phi : ℝ => Real.exp (-(Real.sqrt (2 / 3)) * phi / M)) atBot
      atTop := Real.tendsto_exp_atTop.comp hlin
  have hsub : Tendsto (fun phi : ℝ => Real.exp (-(Real.sqrt (2 / 3)) * phi / M) - 1) atBot
      atTop := Filter.tendsto_atTop_add_const_right _ (-1) hexp |>.congr fun phi => by ring
  have hsq : Tendsto
      (fun phi : ℝ => (1 - Real.exp (-(Real.sqrt (2 / 3)) * phi / M)) ^ 2) atBot atTop := by
    refine (hsub.atTop_mul_atTop₀ hsub).congr fun phi => ?_
    ring
  have hconst : 0 < M ^ 4 / (16 * alpha) := div_pos (by positivity) (by linarith)
  simpa [starobinskyV] using hsq.const_mul_atTop hconst

/-! ## 3. The conformal-mode potential, and what `αR²` buys -/

/-- The conformal-mode spatial potential `V₃(R_c) = −(M²/2)R_c + αR_c²`. -/
def confV (M alpha Rc : ℝ) : ℝ := -(M ^ 2 / 2) * Rc + alpha * Rc ^ 2

/-- **The completed square**: `V₃(R_c) = α(R_c − M²/(4α))² − M⁴/(16α)`. -/
theorem confV_completed_square {M alpha : ℝ} (halpha : alpha ≠ 0) (Rc : ℝ) :
    confV M alpha Rc = alpha * (Rc - M ^ 2 / (4 * alpha)) ^ 2 - M ^ 4 / (16 * alpha) := by
  simp only [confV]
  field_simp
  ring

/-- **The regularized conformal mode is bounded below** by `−M⁴/(16α)`. -/
theorem confV_ge {M alpha : ℝ} (halpha : 0 < alpha) (Rc : ℝ) :
    -(M ^ 4 / (16 * alpha)) ≤ confV M alpha Rc := by
  rw [confV_completed_square halpha.ne' Rc]
  have : 0 ≤ alpha * (Rc - M ^ 2 / (4 * alpha)) ^ 2 := mul_nonneg halpha.le (sq_nonneg _)
  linarith

theorem confV_bddBelow {M alpha : ℝ} (halpha : 0 < alpha) :
    BddBelow (Set.range fun Rc => confV M alpha Rc) :=
  ⟨-(M ^ 4 / (16 * alpha)), by rintro _ ⟨Rc, rfl⟩; exact confV_ge halpha Rc⟩

/-- **Pure general relativity is the unbounded case**: with `α = 0` the conformal-mode
potential is the linear `−(M²/2)R_c`, which tends to `−∞`.  The `αR²` term is exactly what
removes this. -/
theorem confV_zero_alpha_tendsto_atBot {M : ℝ} (hM : M ≠ 0) :
    Tendsto (fun Rc => confV M 0 Rc) atTop atBot := by
  have hpos : 0 < M ^ 2 / 2 := by positivity
  have h : Tendsto (fun Rc : ℝ => -(M ^ 2 / 2) * Rc) atTop atBot :=
    Filter.Tendsto.const_mul_atTop_of_neg (by linarith : -(M ^ 2 / 2) < 0) tendsto_id
  refine h.congr fun Rc => ?_
  simp [confV]

/-! ## 4. The mode Hamiltonian, its essential self-adjointness and its unitary flow -/

/-- The finitely supported states lie in every maximal multiplication domain. -/
theorem lpFiniteModes_le_mulSymbolDomain (lam : ℕ → ℝ) :
    (lpFiniteModes ℕ : Submodule ℂ L2Nat) ≤ mulSymbolDomain lam := by
  intro f hf
  have hsupp : (Function.support (mulSymbolFun lam ((f : L2Nat) : ℕ → ℂ))).Finite := by
    refine Set.Finite.subset hf (fun n hn => ?_)
    simp only [Function.mem_support, mulSymbolFun, ne_eq, mul_eq_zero, not_or] at hn
    exact hn.2
  classical
  change Memℓp (mulSymbolFun lam ((f : L2Nat) : ℕ → ℂ)) 2
  refine (memℓp_gen_iff (by norm_num)).2 ?_
  refine summable_of_ne_finset_zero (s := hsupp.toFinset) fun n hn => ?_
  have : mulSymbolFun lam ((f : L2Nat) : ℕ → ℂ) n = 0 := by
    by_contra hc
    exact hn (hsupp.mem_toFinset.2 hc)
  simp [this]

/-- **The maximal domain of a multiplication operator is dense** in `ℓ²(ℕ)`: it contains
the finitely supported states. -/
theorem mulSymbolDomain_dense (lam : ℕ → ℝ) :
    Dense ((mulSymbolDomain lam : Submodule ℂ L2Nat) : Set L2Nat) :=
  lpFiniteModes_dense.mono (by exact_mod_cast lpFiniteModes_le_mulSymbolDomain lam)

variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)

/-- The Starobinsky conformal-mode potential, mode by mode. -/
def qgR2ModePotential : ℕ → ℝ := fun k => confV M alpha (Rc k)

/-- **The `R + αR²` gravity mode Hamiltonian** in the densitized (Hermite-basis)
realization: multiplication by `(1/16)a_k² − (1/24)b_k² + V₃(R_c k)`. -/
def qgR2ModeHamiltonian :
    mulSymbolDomain (qgModeSymbol a b (qgR2ModePotential M alpha Rc)) →ₗ[ℂ] L2Nat :=
  qgModeHamiltonian a b (qgR2ModePotential M alpha Rc)

/-- **The regularization, at the level of the operator**: the potential part of the mode
Hamiltonian is bounded below by `−M⁴/(16α)`, uniformly in the mode. -/
theorem qgR2Mode_potential_ge (halpha : 0 < alpha) (k : ℕ) :
    -(M ^ 4 / (16 * alpha)) ≤ qgR2ModePotential M alpha Rc k :=
  confV_ge halpha (Rc k)

theorem qgR2Mode_symmetric :
    SymmetricOn (mulSymbolDomain (qgModeSymbol a b (qgR2ModePotential M alpha Rc)))
      (qgR2ModeHamiltonian a b M alpha Rc) :=
  mulSymbolOp_symmetric _ _ (fun _ => le_rfl)

/-- **The `R + αR²` mode Hamiltonian is essentially self-adjoint** on its maximal domain. -/
theorem qgR2Mode_esa :
    EssentiallySelfAdjointOn
      (mulSymbolDomain (qgModeSymbol a b (qgR2ModePotential M alpha Rc)))
      (qgR2ModeHamiltonian a b M alpha Rc) :=
  qgModeHamiltonian_essentiallySelfAdjoint a b (qgR2ModePotential M alpha Rc)

/-- Its adjoint deficiency is trivial at *every* non-real point. -/
theorem qgR2Mode_deficiencyTrivialAt {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (mulSymbolDomain (qgModeSymbol a b (qgR2ModePotential M alpha Rc)))
      (qgR2ModeHamiltonian a b M alpha Rc) z :=
  qgModeHamiltonian_deficiencyTrivialAt a b (qgR2ModePotential M alpha Rc) hz

/-- **The continuous flow of the `R + αR²` gauge-fixed Hamiltonian** (mode realization).
Essential self-adjointness on the dense maximal domain selects one self-adjoint operator,
and Stone's theorem turns it into the complete unitary group `e^{−itH}` solving the
Schrödinger equation on the domain, globally in time. -/
theorem qgR2_stone_flow :
    ∃ (T : UnboundedSelfAdjoint L2Nat) (U : ℝ → (L2Nat →L[ℂ] L2Nat)),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (qgR2ModeHamiltonian a b M alpha Rc)
    (mulSymbolDomain_dense _) (qgR2Mode_symmetric a b M alpha Rc)
    (qgR2Mode_esa a b M alpha Rc)

end

end BookProof.Starobinsky
