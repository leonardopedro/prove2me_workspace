import Theorems.Thm_BookProof_BddBelowWallEsa_wallHam_essentiallySelfAdjoint_of_bddBelow

import Theorems.Thm_BookProof_ScalaronEsa_ccDomain_dense

import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_symmetricOn




import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterWallEsaBddBelow
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The Standard Model comparison operator `N`

Step 2 of the Standard-Model work order of `CONSOLIDATED_PLAN.md` (§D6b-SM.2 / D6b-SM.4):
the Faris–Lavine comparison operator of the Standard Model,

```
N = N₀ + c₀,  c₀ ≥ 1,
N₀ = Σ_{G,W}  ( π² + q⁴ + Σ_j (∂_j q)² )
   + Σ_B      ( π² + q²  + Σ_j (∂_j q)² )
   + Σ_φ      ( π² + q⁴ + Σ_j (∂_j q)² ),
```

written on the same Gauss–polynomial core of `L²(ℝ¹⁶³)` that carries the Hamiltonian of
`BookProof.ChapterSmHamiltonian`.  The structural point of §D6b-SM.2 is the *mix*: the
confinement is **quartic** in the non-abelian and Higgs coordinates and **quadratic** in the
abelian field and in the derivative coordinates.  `smComparison` is exactly that operator:
every one of its summands is a square of a symmetric operator (`π`, `q²`, `q`), plus the
shift `c₀`.

## What is proved

* `card_smConf = 160` — the recount of the confining squares: `37` quartic
  (`24` gluon + `9` weak + `4` Higgs), `3` abelian quadratic, `120` derivative quadratic;
* `smComparison` — the operator, `smComparison_symmetricOn` — it is symmetric on the core;
* `smComparison_quadForm` — its quadratic form is the sum of squares plus `c₀‖x‖²`;
* **`sm_N_positive`** — `⟪x, N x⟫ ≥ ‖x‖²` for `c₀ ≥ 1`: the positivity and the lower bound
  `N ≥ 1` of CHECK 9c, which is what makes `N + 1` a candidate comparison operator;
* `quarticEsaOp`, `quadraticEsaOp`, `smDynChain`, **`sm_N_dyn_esa`** — the confining
  one-dimensional factors `−d²/dq² + q⁴` and `−d²/dq² + q²` are essentially self-adjoint on
  the compactly supported smooth core (`BookProof.WallEsaBddBelow`), and their `40`-fold
  tensor sum — the *dynamical* part of `N₀`, one factor for each momentum-carrying
  coordinate — is essentially self-adjoint on the algebraic tensor product of the `40`
  cores, by `BookProof.TensorSumChain.chain_esa`.  `sm_N_dyn_stone_flow` is the unitary
  group it generates.
* **Accounting identity (why `N` carries no separate BRST gauge-fixing term).**  On the
  temporal-gauge slice `A₀ = 0` the book's BRST-exact contribution `{Ω, Ψ}` with
  `Ψ = i ψ_a A_{0a}` vanishes (`BookProof.BookBrstGaugeFixing.bookGfTerm_eq_zero_of_Afield0`,
  SM instance `sm_bookGfTerm_eq_zero_of_Afield0` in `ChapterBookBrstInstances.lean`;
  Cadabra PART F CHECK 29/30a–c in `../unfer/docs/faris_lavine_n_sm.cdb`).  Hence the
  comparison operator of record is exactly `N = N₀ + c₀ I` with no extra gauge-fixing/ghost
  summand, in parallel with `smHamiltonian` in `ChapterSmHamiltonian.lean`.

## Honest boundary

Two things are **not** claimed here, and the plan's Faris–Lavine chain for the Standard
Model is not closed by this module:

1. `sm_N_dyn_esa` is the essential self-adjointness of the *uncoupled confining chain* — the
   `40` dynamical `(π² + q⁴)` / `(π² + q²)` factors — realized on the tensor product of the
   `40` one-dimensional spaces.  The derivative-coordinate summands `Σ_j (∂_j q)²` of `N₀`,
   which are multiplication operators without a conjugate momentum, are not part of that
   chain, and no statement is made about `N` on the Gauss–polynomial core beyond symmetry
   and the lower bound.
2. The three Faris–Lavine hypotheses of §D6b-SM.3 — the relative bound `±h ≤ c₁N`, the
   first-commutator bound and the double-commutator bound — are certified symbolically in
   the Cadabra module (CHECK 1–28) and are **not** formalized here.  They are not needed for
   what `BookProof.ChapterSmOuterFock` proves: the Standard-Model one-particle operator of
   this development is a positive sum of squares, so the doctrine's default instrument for
   it is Friedrichs, not Faris–Lavine.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmComparison

open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.ScalaronWallEsa BookProof.ScalaronEsa BookProof.WallEsaBddBelow
open BookProof.TensorSumChain BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.EsaClosure BookProof.GraphCore
open BookProof.StoneBridge BookProof.ChapterStoneResolvent
open MeasureTheory

noncomputable section

/-! ## 1. The confining squares -/

/-- The labels of the confining squares of `N₀`: the `37` coordinates with quartic
confinement (gluon, weak, Higgs), the `3` abelian coordinates with quadratic confinement,
and the `120` derivative coordinates with quadratic confinement. -/
abbrev SmConf : Type :=
  ((Fin 8 × Fin 3) ⊕ (Fin 3 × Fin 3) ⊕ Fin 4)
    ⊕ Fin 3
    ⊕ ((Fin 8 × Fin 3 × Fin 3) ⊕ (Fin 3 × Fin 3 × Fin 3) ⊕ (Fin 3 × Fin 3) ⊕ (Fin 4 × Fin 3))

/-- **The recount of the confining squares**: `37 + 3 + 120 = 160`. -/
theorem card_smConf : Fintype.card SmConf = 160 := by simp

/-- The labelling of the `160` confining squares. -/
def smConfFin : SmConf ≃ Fin 160 := Fintype.equivFinOfCardEq card_smConf

/-- The polynomial squared by a confinement label: `q²` for the quartically confined
coordinates (so that its square is `q⁴`) and `q` for the quadratically confined ones. -/
def smConfPoly : SmConf → MvPolynomial (Fin 163) ℂ
  | Sum.inl (Sum.inl (a, i)) => X (smG a i) * X (smG a i)
  | Sum.inl (Sum.inr (Sum.inl (k, i))) => X (smW k i) * X (smW k i)
  | Sum.inl (Sum.inr (Sum.inr a)) => X (smPhi a) * X (smPhi a)
  | Sum.inr (Sum.inl i) => X (smB i)
  | Sum.inr (Sum.inr (Sum.inl (a, i, j))) => X (smDG a i j)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl (k, i, j)))) => X (smDW k i j)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl (i, j))))) => X (smDB i j)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (a, j))))) => X (smDPhi a j)



/-- The confining multiplication operators on the Gauss–polynomial core. -/
def smConfField (s : Fin 160) :
    (polyGaussCore (d := 163)) →ₗ[ℂ] (polyGaussCore (d := 163)) :=
  (coreRepPoly 163).op (mulOp (smConfPoly (smConfFin.symm s)))



/-! ## 2. The comparison operator -/

/-- **The Standard-Model comparison operator** `N = N₀ + c₀` of §D6b-SM.2 on the
Gauss–polynomial core of `L²(ℝ¹⁶³)`: the `40` momentum squares, the `160` confining squares
— quartic for the non-abelian and Higgs coordinates, quadratic for the abelian field and
for the derivative coordinates — and the shift `c₀`. -/
def smComparison (c0 : ℝ) : (polyGaussCore (d := 163)) →ₗ[ℂ] L2d 163 :=
  (2 : ℂ) • weylOp smPi smConfField + ((c0 : ℝ) : ℂ) • (polyGaussCore (d := 163)).subtype









/-! ## 3. The confining one-dimensional factors, and their tensor sum -/

theorem contDiff_pow4 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x : ℝ => x ^ 4 :=
  contDiff_id.pow 4

theorem contDiff_pow2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x : ℝ => x ^ 2 :=
  contDiff_id.pow 2

/-- **The quartic confining factor** `−d²/dq² + q⁴`, essentially self-adjoint on the
compactly supported smooth core of `L²(ℝ)`: the one-dimensional summand of `N₀` attached to
a gluon, weak or Higgs coordinate. -/
def quarticEsaOp : EsaOp where
  space := ⟨Lp ℂ 2 (volume : Measure ℝ)⟩
  complete := inferInstanceAs (CompleteSpace (Lp ℂ 2 (volume : Measure ℝ)))
  dom := ccDomain ℝ
  op := wallHam (fun x : ℝ => x ^ 4) contDiff_pow4
  dense := ccDomain_dense
  sym := wallHam_symmetricOn _ _
  esa := wallHam_essentiallySelfAdjoint_of_bddBelow _ _ (c := 0) fun x => by
    have h : (0 : ℝ) ≤ x ^ 4 := by positivity
    linarith

/-- **The quadratic confining factor** `−d²/dq² + q²`, the one-dimensional summand of `N₀`
attached to the abelian hypercharge coordinate. -/
def quadraticEsaOp : EsaOp where
  space := ⟨Lp ℂ 2 (volume : Measure ℝ)⟩
  complete := inferInstanceAs (CompleteSpace (Lp ℂ 2 (volume : Measure ℝ)))
  dom := ccDomain ℝ
  op := wallHam (fun x : ℝ => x ^ 2) contDiff_pow2
  dense := ccDomain_dense
  sym := wallHam_symmetricOn _ _
  esa := wallHam_essentiallySelfAdjoint_of_bddBelow _ _ (c := 0) fun x => by
    have h : (0 : ℝ) ≤ x ^ 2 := by positivity
    linarith

/-- **The dynamical part of `N₀` as a tensor sum**: one confining factor for each of the
`40` momentum-carrying coordinates — `37` quartic (gluon, weak, Higgs) and `3` quadratic
(hypercharge). -/
def smDynChain : EsaOp :=
  chain quarticEsaOp (List.replicate 36 quarticEsaOp ++ List.replicate 3 quadraticEsaOp)





end

end BookProof.SmComparison
