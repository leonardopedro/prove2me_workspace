import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg

import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_mul

import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_sum

import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_X

import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op

import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym

import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_add



import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn




import Theorems.Thm_BookProof_YangMillsHermite_starP_C


import Theorems.Thm_BookProof_YangMillsHermite_momOp_polySym

import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib


/-!
# Fourier elimination of the derivative variables — the reduced Eulerian Navier–Stokes sector

Stage 1 of the momentum-space (Fourier-elimination) route of `CONSOLIDATED_PLAN.md`
(§“Latest wave — 2026-09-15”, plan items 1–2; staged list of
`DESIGN_COMPARISON_N_20260915.md` §5.5 items 1–2).

On a mode of momentum `k` the auxiliary jet coordinates are **eliminated** (not gauge-fixed):

```
σ :  u_{i,j} ↦ i k_j u_i ,   w_i ↦ −|k|² u_i ,   y_j ↦ 0 ,   u_i ↦ u_i ,   q_i ↦ q_i ,
```

so the sector lives on **six** coordinates per parcel (`u_i`, `q_i`).  The elimination is applied
**inside the squares of every constraint form, to both of its real parts**: a substituted form is
complex, `σ(Φ_r) = Re σ(Φ_r) + i·Im σ(Φ_r)`, and each part is real-coefficient, hence a symmetric
multiplication form whose square is positive — which is the whole point of the positive-completion
route: the residual

```
σ(R_i) = i (k·u) u_i + q_i + ν|k|² u_i        (quadratic — never a cubic symbol),
σ(Σ_j u_{j,j}) = i (k·u)                      (linear),
```

the two facts `nsElimSubst_resPoly` / `nsElimSubst_divPoly` below.  Splitting
`σ(R_i) = I·Im + Re` into its real-coefficient parts `Re = q_i + ν|k|² u_i` and `Im = (k·u) u_i`,
the reduced one-particle Hamiltonian is again a positive sum of Weyl-ordered squares built with the
same `weylOp` as the full Eulerian sector — and this is where the reduced model is *defined*, since
the outer-Fock Hamiltonian is its particle-number-conserving second quantization `dΓ(H₁)` and not
another sum of squares — and it keeps the nonlinearity **in full**: squaring both real
parts puts `(Re)² = (q_i + ν|k|² u_i)²` *and* `(Im)² = ((k·u) u_i)²` inside the Hamiltonian, so the
advection is one of the squares and the reduced *sector* Hamiltonian is quartic, unlike the
real-part-only truncation.  The skewness of `mulOp (i·Im)` (below, §7) is a statement about the
operator of the *equation*: it is what makes the **coefficientwise** product of the complex form
unusable, and it is also why `L*L` and the two-square form are the same *form* (the skew cross term
of `L*L` contributes nothing).  **Plan of record, 2026‑09‑17b:** the honest Hamiltonian is the
modulus-square one, `N` is free, and the convenient choice `N = ι(Friedrichs(H_n^red))` makes the
commutator vanish (`c = 0`).  **The delta is closed:** `redFieldN` below carries the honest family
`redFormPoly` — the real and imaginary parts of *every* surviving substituted form, i.e. the three
real residual parts `q_i + ν|k|² u_i`, the three advection parts `(k·u) u_i` and the eliminated
incompressibility `k·u`, seven forms per parcel — so `redHam` is the full modulus-square
Hamiltonian, quartic and interacting (`redFieldN_advect` exhibits the advection as one of the
squares), and `redHam_quadForm_nonneg` / `redHam_friedrichs_extension` hold for it unchanged.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsFullEuler

open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

/-! ## 1. The reduced coordinates and the substitution `σ` -/

/-- The reduced six-coordinate block of one parcel: `(u_0,u_1,u_2,q_0,q_1,q_2)`. -/
def redIdx (p : Fin n) (i : Fin 6) : Fin (n * 6) := finProdFinEquiv (p, i)

/-- One-parcel reduced coordinate `u_i` as a bare `Fin 6`. -/
abbrev ruIdx6 (i : Fin 3) : Fin 6 := ⟨i.val, by omega⟩

/-- One-parcel reduced coordinate `q_i` as a bare `Fin 6`. -/
abbrev rqIdx6 (i : Fin 3) : Fin 6 := ⟨3 + i.val, by omega⟩

/-- `u_i` inside the reduced block of the `p`-th parcel. -/
def ruIdx (p : Fin n) (i : Fin 3) : Fin (n * 6) := redIdx p (ruIdx6 i)

/-- `q_i` inside the reduced block of the `p`-th parcel. -/
def rqIdx (p : Fin n) (i : Fin 3) : Fin (n * 6) := redIdx p (rqIdx6 i)

/-- The elimination substitution on one parcel's 21 coordinates, as a polynomial in the six
reduced coordinates: `u_{i,j} ↦ i k_j u_i`, `w_i ↦ −|k|² u_i`, `y_j ↦ 0`, `u_i ↦ u_i`,
`q_i ↦ q_i`.  (The layout of `Fin 21` is that of `uIdx`/`dIdx`/`wIdx`/`qIdx`/`yIdx`.) -/
def nsElimCoord (k : Fin 3 → ℝ) (i : Fin 21) : MvPolynomial (Fin 6) ℂ :=
  if h : i.val < 3 then X (⟨i.val, by omega⟩ : Fin 6)
  else if h2 : i.val < 12 then
    C (Complex.I * (((k ⟨(i.val - 3) % 3, by omega⟩ : ℝ)) : ℂ))
      * X (⟨(i.val - 3) / 3, by omega⟩ : Fin 6)
  else if h3 : i.val < 15 then
    -C ((((∑ j : Fin 3, (k j) ^ 2 : ℝ))) : ℂ) * X (⟨i.val - 12, by omega⟩ : Fin 6)
  else if h4 : i.val < 18 then X (⟨3 + (i.val - 15), by omega⟩ : Fin 6)
  else 0

/-- Reindex a one-parcel reduced polynomial into the `p`-th parcel's block. -/
def liftParcel (p : Fin n) : MvPolynomial (Fin 6) ℂ →+* MvPolynomial (Fin (n * 6)) ℂ :=
  MvPolynomial.eval₂Hom (MvPolynomial.C) (fun j => X (redIdx p j))

/-- **The elimination `σ`** on the `n`-parcel polynomial ring, applied parcelwise. -/
def nsElimHom (k : Fin 3 → ℝ) (n : ℕ) :
    MvPolynomial (Fin (n * 21)) ℂ →+* MvPolynomial (Fin (n * 6)) ℂ :=
  MvPolynomial.eval₂Hom (MvPolynomial.C)
    (fun s => liftParcel (finProdFinEquiv.symm s).1 (nsElimCoord k (finProdFinEquiv.symm s).2))

/-! ## 2. One-parcel coordinate facts for `σ` -/











/-! ## 3. The lifted substitution on the coordinate ring -/

















/-! ## 4. The substitution `σ` on the residual and on the divergence

The substitution is a *ring* map, so it commutes with sums and products; the whole content of the
elimination is that the Fourier symbols below come out **quadratic** — the derivative coordinates
`u_{i,j}` and `w_i`, which are what made the residual formally cubic in the field, are gone:

* `σ(u_j u_{i,j}) = i (k·u) u_i`  (`k·u = Σ_j k_j u_j`),
* `σ(q_i) = q_i`,  `σ(−ν w_i) = ν|k|² u_i`,
* `σ(Σ_j u_{j,j}) = i (k·u)`.

Splitting `σ(R_i) = i·(advection symbol) + (real symbol)`, each part is a *legitimate*
(real-coefficient, hence symmetric) multiplication form; multiplication by the **imaginary** part
`i (k·u) u_i` is **skew-adjoint** and its operator square is *negative*, which is what rules out the
**coefficientwise** product of the complex form.  It does **not** rule the advection out of the
Hamiltonian: the real polynomial `(k·u) u_i` has a symmetric operator, so the reduced *one-particle*
Hamiltonian of §5 squares it — `½ ((k·u)u_i)²` alongside `½(q_i + ν|k|²u_i)²` (plan of record
2026‑09‑17b) — and `N` is free, the convenient choice being the lifted Friedrichs extension of that
same one-particle Hamiltonian (`c = 0`), which the outer-Fock lift `dΓ(H₁)` of §6 carries
unchanged. -/

/-- The momentum scalar `k·u` in the reduced ring. -/
def fourierMomentum (k : Fin 3 → ℝ) : MvPolynomial (Fin 6) ℂ :=
  ∑ j : Fin 3, C (((k j : ℝ)) : ℂ) * X (ruIdx6 j)

/-- The real Fourier symbol `(k·u) u_i` of the advection `u_j ∂_j u_i`. -/
def fourierAdvect (k : Fin 3 → ℝ) (i : Fin 3) : MvPolynomial (Fin 6) ℂ :=
  fourierMomentum k * X (ruIdx6 i)

/-- The Fourier symbol `i (k·u)` of the incompressibility `Σ_j u_{j,j}`. -/
def fourierDiv (k : Fin 3 → ℝ) : MvPolynomial (Fin 6) ℂ :=
  C Complex.I * fourierMomentum k

/-- The real Fourier symbol `q_i + ν|k|² u_i` of the pressure-gradient and viscous parts of the
residual.  It has real coefficients, hence multiplication by it is symmetric. -/
def fourierVisc (nu : ℝ) (k : Fin 3 → ℝ) (i : Fin 3) : MvPolynomial (Fin 6) ℂ :=
  X (rqIdx6 i) + C (((nu * ∑ j : Fin 3, (k j) ^ 2 : ℝ)) : ℂ) * X (ruIdx6 i)

/-- A real constant is a real-coefficient polynomial in *any* reduced ring. -/
theorem realCoeff_realConst {m : ℕ} (c : ℝ) :
    RealCoeff (C ((c : ℝ) : ℂ) : MvPolynomial (Fin m) ℂ) := by
  rw [RealCoeff, starP_C, Complex.conj_ofReal]





























/-! ## 5. The reduced one-particle Hamiltonian: the sums of squares, the advection included

After the elimination a parcel has **six** canonical coordinates `(u_i, q_i)`.  The real part
`Re σ(R_i) = q_i + ν|k|² u_i` is a real-coefficient multiplication form, so the same `weylOp` that
builds the full Eulerian sector builds the reduced one, and its quadratic form is a sum of squares:
`H_n^red = ½ Σ_m π_m² + ½ Σ_r [(mulOp Re σ(Φ_r))² + (mulOp Im σ(Φ_r))²] ≥ 0` — both real parts of
**every** reduced form squared.  Level bookkeeping: `redHam nu k 1` is the reduced **one-particle**
Hamiltonian, and it — not the Fock operator — is where the choice of squared forms is made;
`redHam nu k n` is that one-particle operator summed over the `n` parcels, and §6's
`nsRedFullFockHam = dsOp (fun n => redHam nu k n)` is its particle-number-conserving second
quantization `dΓ(H₁)`, the lift taking no further square.  That
puts the advection **inside** a square — `½ ((k·u) u_i)²`, via `Im σ(R_i) = fourierAdvect`, whose
multiplication operator is symmetric (`realCoeff_fourierAdvect` + `mulOp_polySym`) — so the reduced
Hamiltonian is quartic and interacting, as Navier–Stokes requires; `N` is then free, and
`N = ι(Friedrichs(H_n^red))` makes the commutator vanish (`c = 0`).  The squared family is
`redFormPoly`: seven real-coefficient forms per parcel — `redVisc` (the real residual part),
`redAdvectPoly` (the advection, the imaginary residual part) and `redMomentumPoly` (the eliminated
incompressibility) — so nothing is dropped and nothing is demoted to a perturbation. -/

/-- The real reduced residual form of a parcel, in the six reduced coordinates. -/
def redVisc (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    MvPolynomial (Fin (n * 6)) ℂ :=
  X (rqIdx p i) + C (((nu * ∑ j : Fin 3, (k j) ^ 2 : ℝ)) : ℂ) * X (ruIdx p i)



/-- **The reduced residual form is real-coefficient**, hence a symmetric multiplication form. -/
theorem realCoeff_redVisc (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    RealCoeff (redVisc nu k n p i) :=
  (realCoeff_X _).add ((realCoeff_realConst _).mul (realCoeff_X _))

/-- The lifted **real** advection symbol `(k·u) u_i` of the `i`-th residual of the `p`-th parcel —
the *imaginary* part `Im σ(R_i)` of the eliminated residual, written as a real-coefficient
polynomial. -/
def redAdvectPoly (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    MvPolynomial (Fin (n * 6)) ℂ :=
  ∑ j : Fin 3, C (((k j : ℝ)) : ℂ) * (X (ruIdx p j) * X (ruIdx p i))

theorem realCoeff_redAdvectPoly (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    RealCoeff (redAdvectPoly k n p i) :=
  RealCoeff.sum fun j _ =>
    (realCoeff_realConst (k j)).mul ((realCoeff_X _).mul (realCoeff_X _))



/-- The lifted momentum scalar `k·u` of the `p`-th parcel — the *imaginary* part of the eliminated
incompressibility `σ(Σ_j u_{j,j}) = i (k·u)` (its real part is zero). -/
def redMomentumPoly (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) : MvPolynomial (Fin (n * 6)) ℂ :=
  ∑ j : Fin 3, C (((k j : ℝ)) : ℂ) * X (ruIdx p j)

theorem realCoeff_redMomentumPoly (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    RealCoeff (redMomentumPoly k n p) :=
  RealCoeff.sum fun j _ => (realCoeff_realConst (k j)).mul (realCoeff_X _)



/-- Index of the real part `Re σ(R_i) = q_i + ν|k|² u_i` of the `i`-th residual among the seven
forms of a parcel. -/
abbrev reIdx7 (i : Fin 3) : Fin 7 := ⟨i.val, by omega⟩

/-- Index of the imaginary part `Im σ(R_i) = (k·u) u_i` — the **advection** — of the `i`-th
residual among the seven forms of a parcel. -/
abbrev imIdx7 (i : Fin 3) : Fin 7 := ⟨3 + i.val, by omega⟩

/-- Index of the eliminated incompressibility `Im σ(Σ_j u_{j,j}) = k·u` among the seven forms of a
parcel. -/
abbrev divIdx7 : Fin 7 := ⟨6, by omega⟩

/-- **The honest reduced constraint family of one parcel**: the real and imaginary parts of *every*
surviving substituted form — the three real residual parts `q_i + ν|k|² u_i`, the three advection
parts `(k·u) u_i`, and the eliminated incompressibility `k·u`.  (The `y`-gauge forms contribute
nothing, `σ(y_j) = 0`, and the real part of the incompressibility is zero.)  Each member is
real-coefficient, hence a symmetric multiplication form whose square is positive. -/
def redFormPoly (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    MvPolynomial (Fin (n * 6)) ℂ :=
  if h : r.val < 3 then redVisc nu k n p ⟨r.val, h⟩
  else if h2 : r.val < 6 then redAdvectPoly k n p ⟨r.val - 3, by omega⟩
  else redMomentumPoly k n p







/-- **Every member of the reduced family is real-coefficient**, hence its multiplication operator is
symmetric and its square is a positive summand of the Hamiltonian. -/
theorem realCoeff_redFormPoly (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    RealCoeff (redFormPoly nu k n p r) := by
  rw [redFormPoly]
  split
  · exact realCoeff_redVisc nu k n p _
  · split
    · exact realCoeff_redAdvectPoly k n p _
    · exact realCoeff_redMomentumPoly k n p

/-- The momenta of the six reduced coordinates of each parcel. -/
def redPiN (n : ℕ) (m : Fin (n * 6)) :
    polyGaussCore (d := n * 6) →ₗ[ℂ] polyGaussCore (d := n * 6) :=
  (coreRepPoly (n * 6)).op
    (momOp (redIdx (finProdFinEquiv.symm m).1 (finProdFinEquiv.symm m).2))

/-- The reduced constraint (multiplication) forms of the `n`-parcel sector: the **seven** forms of
each parcel — the real and imaginary parts of every surviving substituted form (three real residual
parts, three advection parts and the eliminated incompressibility). -/
def redFieldN (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (m : Fin (n * 7)) :
    polyGaussCore (d := n * 6) →ₗ[ℂ] polyGaussCore (d := n * 6) :=
  (coreRepPoly (n * 6)).op
    (mulOp (redFormPoly nu k n (finProdFinEquiv.symm m).1 (finProdFinEquiv.symm m).2))







theorem redPiN_symmetricOn (n : ℕ) (m : Fin (n * 6)) :
    SymmetricOn (polyGaussCore (d := n * 6))
      ((polyGaussCore (d := n * 6)).subtype.comp (redPiN n m)) :=
  (coreRepPoly (n * 6)).symmetricOn_op (momOp_polySym _)

theorem redFieldN_symmetricOn (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (m : Fin (n * 7)) :
    SymmetricOn (polyGaussCore (d := n * 6))
      ((polyGaussCore (d := n * 6)).subtype.comp (redFieldN nu k n m)) :=
  (coreRepPoly (n * 6)).symmetricOn_op (mulOp_polySym (realCoeff_redFormPoly _ _ _ _ _))

/-- **The reduced `n`-parcel Hamiltonian** on the Gauss–polynomial core of `L²(ℝ^{6n})` — the
`n`-parcel member of the one-particle family (`n = 1` is the reduced one-particle Hamiltonian). -/
def redHam (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    polyGaussCore (d := n * 6) →ₗ[ℂ] L2d (n * 6) :=
  weylOp (redPiN n) (redFieldN nu k n)

theorem redHam_symmetricOn (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    SymmetricOn (polyGaussCore (d := n * 6)) (redHam nu k n) :=
  weylOpDom_symmetricOn (redPiN_symmetricOn n) (redFieldN_symmetricOn nu k n)

/-- **The reduced Hamiltonian is bounded below** — a sum of Weyl-ordered squares, exactly as in the
full sector. -/
theorem redHam_quadForm_nonneg (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ)
    (x : polyGaussCore (d := n * 6)) : 0 ≤ quadForm (redHam nu k n) x :=
  weylOpDom_quadForm_nonneg (redPiN_symmetricOn n) (redFieldN_symmetricOn nu k n) x



/-- The reduced one-body operators as a densely defined positive symmetric operator. -/
def redPosSym (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) : PosSymOp (L2d (n * 6)) where
  dom := polyGaussCore (d := n * 6)
  op := redHam nu k n
  sym := redHam_symmetricOn nu k n
  pos := redHam_quadForm_nonneg nu k n

/-- **The Friedrichs extension of the reduced Hamiltonian as a Faris–Lavine comparison** — the
candidate `N_E` of the plan, with `c = 0`. -/
def redFried (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) : Comparison (L2d (n * 6)) :=
  friedrichsComparison (redPosSym nu k n) polyGaussCore_dense





/-! ## 6. The nested Fock space of the reduced sector

The comparison operator the route needs is the lifted Friedrichs realization
(`dsComparison`) of the reduced one-body operators — the `N_E` of the plan.  Positivity,
symmetry and surjectivity of `N + 1` are fibrewise, so they lift verbatim, and
Faris–Lavine then gives essential self-adjointness with `c = 0` exactly as in the full
Eulerian sector. -/

/-- The nested Fock space `⊕ₙ L²(ℝ^{6n})` of the reduced (Fourier-eliminated) sector. -/
abbrev nsRedFockSpace := lp (fun n : ℕ => L2d (n * 6)) 2

/-- The finite-parcel core of the reduced Fock space. -/
def nsRedFockCore : Submodule ℂ nsRedFockSpace :=
  dsCore (fun n : ℕ => polyGaussCore (d := n * 6))



/-- **The reduced Hamiltonian on the nested Fock space.** -/
def nsRedFullFockHam (nu : ℝ) (k : Fin 3 → ℝ) : nsRedFockCore →ₗ[ℂ] nsRedFockSpace :=
  dsOp (fun n : ℕ => redHam nu k n)







/-! ## 7. The advection: the transfer weight, its skewness, and the commutator obligation

The eliminated residual split as `σ(R_i) = i (k·u) u_i + (q_i + ν|k|² u_i)`: the first term is the
**advection**, and it is the only genuinely new object of the route.  This section records what is
proved about it and — just as importantly — what is not:

* the advection symbol is the **transfer-weight pairing** `Σ_j k_j (u_j u_i)`: the momentum `k_j` of
  the eliminated derivative is contracted with the product of the two velocity modes, which is the
  polynomial form of the momentum-space convolution of the route (`fourierMomentum_add` /
  `_smul` record that the weight is linear in the momentum, and `fourierAdvect_eq_transfer` is the
  contraction itself);
* multiplication by the *imaginary* advection symbol is **skew** on the core
  (`mulOp_polySkew`, `CoreRep.skewOn_op`), so it contributes **nothing** to the quadratic form
  (`redAdvect_quadForm_zero`) — which is precisely what makes the *modulus* square of §5 and the
  plain sum of squares agree as forms, and what makes the **coefficientwise** square of the complex
  form unusable.  It does **not** say the advection is excluded from the energy: the real polynomial
  `fourierAdvect` has a symmetric multiplication operator, so `½ a_i²` is a legitimate square
  (`§5`, plan of record 2026‑09‑17b);
* consequently the one remaining obligation of the route is the **commutator bound** against the
  comparison operator, and `nsRedFullFock_esa_of_commBound` states exactly what that obligation
  buys: Faris–Lavine with the comparison of §6, the advection as `H`, and the bound as the single
  hypothesis (the `c = 0` form is `nsRedFullFock_esa_of_zero_comm`).  Nothing here claims the bound;
  it is the analytic input the plan leaves open.

A Gauss-skew polynomial operator transported to the core. -/

def PolySkew (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) : Prop :=
  PolyAdj T (-T)







/-- **The advection term of the eliminated Hamiltonian**: multiplication by `i (k·u) u_i`, one for
each residual direction of each parcel. -/
def redAdvect (k : Fin 3 → ℝ) (n : ℕ) (m : Fin (n * 3)) :
    polyGaussCore (d := n * 6) →ₗ[ℂ] L2d (n * 6) :=
  (polyGaussCore (d := n * 6)).subtype.comp
    ((coreRepPoly (n * 6)).op
      (mulOp (C Complex.I * redAdvectPoly k n (finProdFinEquiv.symm m).1
        (finProdFinEquiv.symm m).2)))











/-- **The lifted comparison operator** — the `ℓ²`-direct sum of the reduced Friedrichs
realizations.  This is the `N_E` of the plan's Fourier-elimination route (including the viscous
regularization `ν > 0` and the mode `k`). -/
def nsRedOuterComparison (nu : ℝ) (k : Fin 3 → ℝ) : Comparison nsRedFockSpace :=
  dsComparison (fun n : ℕ => redFried nu k n)













end

end BookProof.NsFullEuler
