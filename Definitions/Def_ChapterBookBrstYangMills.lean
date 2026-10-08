import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib


/-!
# The BRST charge **exactly as defined in `book.tex`**

`book.tex`, chapter *"Quantization due to time-evolution: Yang–Mills and Classical Statistical
Field Theory"*, §*"Pure SU(3) Yang-Mills theory"* (lines ~7060 and ~7343) defines the BRST
charge of a gauge theory with structure constants `f_{abc}` by the **density**

```
Ω(x) = π^μ_a ∂_μ ψ†_a − π^μ_a f_{abc} A_{μb} ψ†_c − (i/2) f_{abc} ψ†_a ψ†_b ψ_c
```

together with the canonical relations of the same section,

```
[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab},   {ψ_a, ψ†_b} = δ_{ab},   {ψ_a,ψ_b} = {ψ†_a,ψ†_b} = 0 .
```

This module builds that charge: the three terms above, with the momenta, gauge-field
multiplication operators and ghosts realized as operators on a concrete graded state space,
and it *derives* the constraint algebra — the Gauss law — from the canonical relations
instead of assuming it.

## The gauge algebra and the derivative term

The book's gauge field takes values in the Lie algebra of the gauge group at every point of
space.  Here the local gauge algebra is modelled by a finite-dimensional Lie algebra `𝔤`
(basis `T_a`, `a : Fin N`, structure constants `f_{abc}` totally antisymmetric, as for the
book's `SU(N)` generators normalized by `tr(T_aT_b) = ½δ_{ab}`) carrying, for each spacetime
direction `μ`, a **derivation** `∂_μ` (matrix `D μ`).  The derivation property
`∂_μ[X,Y] = [∂_μX,Y] + [X,∂_μY]` is exactly what makes the first term `π^μ_a ∂_μψ†_a` of the
book's charge enter the Gauss-law algebra correctly.  `∂_μ = 0` is the constant
(single-multiplet) case; `∂_μ = ad_{X_μ}` is a non-trivial instance, exhibited below.

## What is proved

* `bookCCR`, `bookGhostCar` — the canonical (anti)commutation relations of the book's section
  hold in the realization: `[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`, `{ψ_a, ψ†_b} = δ_{ab}`, and the
  bosonic and ghost operators commute.
* `gaussGen_bracket` — **the Gauss-law constraint algebra**: the operators `𝒢_c` appearing as
  the coefficient of the ghost `ψ†_c` in the book's charge close into the gauge algebra,
  `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`.  This is *derived* from the canonical relations, the
  derivation property of `∂_μ` and the Jacobi identity.
* `bookOmega_eq_brstCharge` — the book's charge is `i` times the abstract BRST charge of
  `BookProof.QuantumGravityBrstCharge` with these constraints; in particular the coefficient
  `−i/2` of the cubic ghost term of `book.tex` is exactly the one nilpotency requires.
* **`bookOmega_nilpotent`** — `Ω² = 0` for the book's charge.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.BookBrstYangMills

open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

/-! ## 1. The gauge algebra with its spacetime derivations -/

/-- The data of the book's gauge algebra: totally antisymmetric structure constants obeying
the Jacobi identity (the `SU(N)` structure constants of the book's §"Pure SU(3) Yang-Mills
theory"), together with the four spacetime derivations `∂_μ` in the same basis,
`∂_μ T_a = Σ_b (D μ)_{ab} T_b`. -/
structure GaugeAlgebra (N : ℕ) where
  /-- structure constants, `[T_a, T_b] = Σ_c f_{abc} T_c` -/
  f : Fin N → Fin N → Fin N → ℝ
  /-- antisymmetry in the first two indices -/
  antisymm : ∀ a b c, f a b c = -f b a c
  /-- cyclic invariance; together with `antisymm` this is total antisymmetry, which is what
  the book's normalization `tr(T_aT_b) = ½δ_{ab}` provides -/
  cyclic : ∀ a b c, f a b c = f b c a
  /-- the Jacobi identity -/
  jacobi : ∀ a b c d, ∑ e, (f a b e * f e c d + f b c e * f e a d + f c a e * f e b d) = 0
  /-- the spacetime derivatives in the basis: `∂_μ T_a = Σ_b (D μ)_{ab} T_b` -/
  D : Fin 4 → Fin N → Fin N → ℝ
  /-- `∂_μ` is a derivation: `∂_μ[T_a,T_b] = [∂_μT_a, T_b] + [T_a, ∂_μT_b]` -/
  leibniz : ∀ μ a b c, ∑ h, f a b h * D μ h c
    = ∑ h, D μ a h * f h b c + ∑ h, D μ b h * f a h c

variable {N : ℕ} (G : GaugeAlgebra N)

/-! ## 2. Two index identities of the gauge algebra -/

/-- The contracted product of two structure constants. -/
def strProd (p q r s : Fin N) : ℝ := ∑ m, G.f p q m * G.f r s m













/-! ## 3. The state space: fields and ghosts -/

/-- The bosonic field coordinates: one polynomial variable per gauge-field component
`A_{μa}`. -/
abbrev FieldPoly (N : ℕ) : Type := MvPolynomial (Fin 4 × Fin N) ℂ

/-- The ghost sector: the `ℤ₂^N` occupation space `Λ(ℂ^N)`, one ghost per gauge generator. -/
abbrev GhostSpace (N : ℕ) : Type := ExteriorAlgebra ℂ (Fin N → ℂ)

/-- The graded state space of the book's section: bosonic fields tensored with ghosts. -/
abbrev BookState (N : ℕ) : Type := TensorProduct ℂ (FieldPoly N) (GhostSpace N)

/-- The ghost creation operator `ψ†_a`. -/
def ghostCreN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  LinearMap.mulLeft ℂ (ExteriorAlgebra.ι ℂ (Pi.single a 1))

/-- The ghost annihilation operator `ψ_a`. -/
def ghostAnnN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  CliffordAlgebra.contractLeft (LinearMap.proj a)



/-- A bosonic operator on the graded space. -/
def bosOpN (T : Module.End ℂ (FieldPoly N)) : Module.End ℂ (BookState N) :=
  LinearMap.rTensor (GhostSpace N) T

/-- A ghost operator on the graded space. -/
def ghostOpN (T : Module.End ℂ (GhostSpace N)) : Module.End ℂ (BookState N) :=
  LinearMap.lTensor (FieldPoly N) T

ang–Mills and Classical Statistical
Field Theory"*, §*"Pure SU(3) Yang-Mills theory"* (lines ~7060 and ~7343) defines the BRST
charge of a gauge theory with structure constants `f_{abc}` by the **density**

```
Ω(x) = π^μ_a ∂_μ ψ†_a − π^μ_a f_{abc} A_{μb} ψ†_c − (i/2) f_{abc} ψ†_a ψ†_b ψ_c
```

together with the canonical relations of the same section,

```
[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab},   {ψ_a, ψ†_b} = δ_{ab},   {ψ_a,ψ_b} = {ψ†_a,ψ†_b} = 0 .
```

This module builds that charge: the three terms above, with the momenta, gauge-field
multiplication operators and ghosts realized as operators on a concrete graded state space,
and it *derives* the constraint algebra — the Gauss law — from the canonical relations
instead of assuming it.

## The gauge algebra and the derivative term

The book's gauge field takes values in the Lie algebra of the gauge group at every point of
space.  Here the local gauge algebra is modelled by a finite-dimensional Lie algebra `𝔤`
(basis `T_a`, `a : Fin N`, structure constants `f_{abc}` totally antisymmetric, as for the
book's `SU(N)` generators normalized by `tr(T_aT_b) = ½δ_{ab}`) carrying, for each spacetime
direction `μ`, a **derivation** `∂_μ` (matrix `D μ`).  The derivation property
`∂_μ[X,Y] = [∂_μX,Y] + [X,∂_μY]` is exactly what makes the first term `π^μ_a ∂_μψ†_a` of the
book's charge enter the Gauss-law algebra correctly.  `∂_μ = 0` is the constant
(single-multiplet) case; `∂_μ = ad_{X_μ}` is a non-trivial instance, exhibited below.

## What is proved

* `bookCCR`, `bookGhostCar` — the canonical (anti)commutation relations of the book's section
  hold in the realization: `[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`, `{ψ_a, ψ†_b} = δ_{ab}`, and the
  bosonic and ghost operators commute.
* `gaussGen_bracket` — **the Gauss-law constraint algebra**: the operators `𝒢_c` appearing as
  the coefficient of the ghost `ψ†_c` in the book's charge close into the gauge algebra,
  `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`.  This is *derived* from the canonical relations, the
  derivation property of `∂_μ` and the Jacobi identity.
* `bookOmega_eq_brstCharge` — the book's charge is `i` times the abstract BRST charge of
  `BookProof.QuantumGravityBrstCharge` with these constraints; in particular the coefficient
  `−i/2` of the cubic ghost term of `book.tex` is exactly the one nilpotency requires.
* **`bookOmega_nilpotent`** — `Ω² = 0` for the book's charge.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.BookBrstYangMills

open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

/-! ## 1. The gauge algebra with its spacetime derivations -/

/-- The data of the book's gauge algebra: totally antisymmetric structure constants obeying
the Jacobi identity (the `SU(N)` structure constants of the book's §"Pure SU(3) Yang-Mills
theory"), together with the four spacetime derivations `∂_μ` in the same basis,
`∂_μ T_a = Σ_b (D μ)_{ab} T_b`. -/
structure GaugeAlgebra (N : ℕ) where
  /-- structure constants, `[T_a, T_b] = Σ_c f_{abc} T_c` -/
  f : Fin N → Fin N → Fin N → ℝ
  /-- antisymmetry in the first two indices -/
  antisymm : ∀ a b c, f a b c = -f b a c
  /-- cyclic invariance; together with `antisymm` this is total antisymmetry, which is what
  the book's normalization `tr(T_aT_b) = ½δ_{ab}` provides -/
  cyclic : ∀ a b c, f a b c = f b c a
  /-- the Jacobi identity -/
  jacobi : ∀ a b c d, ∑ e, (f a b e * f e c d + f b c e * f e a d + f c a e * f e b d) = 0
  /-- the spacetime derivatives in the basis: `∂_μ T_a = Σ_b (D μ)_{ab} T_b` -/
  D : Fin 4 → Fin N → Fin N → ℝ
  /-- `∂_μ` is a derivation: `∂_μ[T_a,T_b] = [∂_μT_a, T_b] + [T_a, ∂_μT_b]` -/
  leibniz : ∀ μ a b c, ∑ h, f a b h * D μ h c
    = ∑ h, D μ a h * f h b c + ∑ h, D μ b h * f a h c

variable {N : ℕ} (G : GaugeAlgebra N)

/-! ## 2. Two index identities of the gauge algebra -/

/-- The contracted product of two structure constants. -/
def strProd (p q r s : Fin N) : ℝ := ∑ m, G.f p q m * G.f r s m

theorem strProd_symm (p q r s : Fin N) : strProd G p q r s = strProd G r s p q :=
  Finset.sum_congr rfl fun _ _ => mul_comm _ _

theorem strProd_swap12 (p q r s : Fin N) : strProd G p q r s = -strProd G q p r s := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm p q m]; ring

theorem strProd_swap34 (p q r s : Fin N) : strProd G p q r s = -strProd G p q s r := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm r s m]; ring

/-- The Jacobi identity in contracted form. -/
theorem strProd_jacobi (x y z w : Fin N) :
    strProd G x y z w + strProd G y z x w + strProd G z x y w = 0 := by
  have h := G.jacobi x y z w
  rw [← h]
  simp only [strProd]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [G.cyclic m z w, G.cyclic m x w, G.cyclic m y w]

/-- **Constant part of the Gauss-law closure**: the derivation property of `∂_μ`. -/
theorem gauss_const_identity (μ : Fin 4) (a c e : Fin N) :
    (∑ b, G.f a b e * (-(G.D μ c b))) - (∑ b, G.f a b c * (-(G.D μ e b)))
      = ∑ h, G.f c e h * (-(G.D μ h a)) := by
  have hl := G.leibniz μ c e a
  have e1 : ∀ h : Fin N, G.D μ c h * G.f h e a = G.f a h e * G.D μ c h := by
    intro h
    have : G.f h e a = G.f a h e := by rw [G.cyclic h e a, G.cyclic e a h]
    rw [this, mul_comm]
  have e2 : ∀ h : Fin N, G.D μ e h * G.f c h a = -(G.f a h c * G.D μ e h) := by
    intro h
    have : G.f c h a = -G.f a h c := by rw [G.cyclic c h a, G.antisymm h a c]
    rw [this]; ring
  have hR : ∑ h, G.f c e h * (-(G.D μ h a)) = -(∑ h, G.f c e h * G.D μ h a) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => by ring
  have s1 : ∑ b, G.f a b e * (-(G.D μ c b)) = -(∑ b, G.f a b e * G.D μ c b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s2 : ∑ b, G.f a b c * (-(G.D μ e b)) = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s3 : ∑ h, G.D μ c h * G.f h e a = ∑ b, G.f a b e * G.D μ c b :=
    Finset.sum_congr rfl fun h _ => e1 h
  have s4 : ∑ h, G.D μ e h * G.f c h a = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => e2 h
  rw [hR, hl, s1, s2, s3, s4]
  ring

/-- **Field-dependent part of the Gauss-law closure**: the Jacobi identity. -/
theorem gauss_field_identity (a c e g : Fin N) :
    (∑ b, G.f a b e * G.f b g c) - (∑ b, G.f a b c * G.f b g e)
      = ∑ h, G.f c e h * G.f a g h := by
  have t1 : (∑ b, G.f a b e * G.f b g c) = strProd G e a g c := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b e, G.cyclic b e a, G.cyclic b g c]
  have t2 : (∑ b, G.f a b c * G.f b g e) = strProd G c a g e := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b c, G.cyclic b c a, G.cyclic b g e]
  have t3 : (∑ h, G.f c e h * G.f a g h) = strProd G c e a g := rfl
  rw [t1, t2, t3]
  have J1 := strProd_jacobi G e a g c
  have J2 := strProd_jacobi G c a g e
  have J3 := strProd_jacobi G a c g e
  have r1 : strProd G a g e c = -strProd G a g c e := strProd_swap34 G a g e c
  have r2 : strProd G g e a c = strProd G a c g e := strProd_symm G g e a c
  have r3 : strProd G g c a e = -strProd G c g a e := strProd_swap12 G g c a e
  have r4 : strProd G g a c e = -strProd G a g c e := strProd_swap12 G g a c e
  have r5 : strProd G c e a g = strProd G a g c e := strProd_symm G c e a g
  rw [r5]
  linarith [J1, J2, J3, r1, r2, r3, r4]

/-! ## 3. The state space: fields and ghosts -/

/-- The bosonic field coordinates: one polynomial variable per gauge-field component
`A_{μa}`. -/
abbrev FieldPoly (N : ℕ) : Type := MvPolynomial (Fin 4 × Fin N) ℂ

/-- The ghost sector: the `ℤ₂^N` occupation space `Λ(ℂ^N)`, one ghost per gauge generator. -/
abbrev GhostSpace (N : ℕ) : Type := ExteriorAlgebra ℂ (Fin N → ℂ)

/-- The graded state space of the book's section: bosonic fields tensored with ghosts. -/
abbrev BookState (N : ℕ) : Type := TensorProduct ℂ (FieldPoly N) (GhostSpace N)

/-- The ghost creation operator `ψ†_a`. -/
def ghostCreN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  LinearMap.mulLeft ℂ (ExteriorAlgebra.ι ℂ (Pi.single a 1))

/-- The ghost annihilation operator `ψ_a`. -/
def ghostAnnN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  CliffordAlgebra.contractLeft (LinearMap.proj a)

theorem ghostN_car : GhostCAR (ghostCreN (N := N)) (ghostAnnN (N := N)) := by
  constructor
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.mulLeft_apply,
      LinearMap.zero_apply, ← mul_assoc]
    rw [← add_mul, CliffordAlgebra.ι_mul_ι_add_swap]
    simp [QuadraticMap.polar]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostAnnN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply]
    rw [CliffordAlgebra.contractLeft_comm, neg_add_cancel]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, ghostAnnN, LinearMap.add_apply, Module.End.mul_apply,
      LinearMap.mulLeft_apply, CliffordAlgebra.contractLeft_ι_mul]
    by_cases h : a = b
    · subst h; simp
    · simp [h]

/-- A bosonic operator on the graded space. -/
def bosOpN (T : Module.End ℂ (FieldPoly N)) : Module.End ℂ (BookState N) :=
  LinearMap.rTensor (GhostSpace N) T

/-- A ghost operator on the graded space. -/
def ghostOpN (T : Module.End ℂ (GhostSpace N)) : Module.End ℂ (BookState N) :=
  LinearMap.lTensor (FieldPoly N) T

theorem bosOpN_mul (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S * T) = bosOpN S * bosOpN T := by
  simp [bosOpN, Module.End.mul_eq_comp, LinearMap.rTensor_comp]





theorem bosOpN_zero : bosOpN (0 : Module.End ℂ (FieldPoly N)) = 0 := by simp [bosOpN]

















/-- The ghost creation operator `ψ†_a` on the graded space. -/
def chiOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostCreN a)

/-- The ghost annihilation operator `ψ_a` on the graded space. -/
def betaOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostAnnN a)



/-! ## 4. The gauge field and its conjugate momentum -/

/-- The gauge-field operator `A_{μa}` on the polynomial core: multiplication by the
coordinate. -/
def AfieldPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  LinearMap.mulLeft ℂ (X (μ, a))

/-- The conjugate momentum `π^μ_a = −i ∂/∂A_{μa}` on the polynomial core. -/
def momPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  (-Complex.I) • (pderiv (μ, a) : Derivation ℂ (FieldPoly N) (FieldPoly N)).toLinearMap

/-- The gauge-field operator on the graded space. -/
def Afield (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (AfieldPoly μ a)

/-- The conjugate momentum on the graded space. -/
def mom (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (momPoly μ a)













/-! ## 5. The Gauss-law constraints -/

/-- An affine combination `α·1 + Σ_g β_g A_{μg}` of the field coordinates in one spacetime
direction: the shape of an infinitesimal gauge transformation of `A_{μa}`. -/
def vecComb (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) : FieldPoly N :=
  ((α : ℝ) : ℂ) • (1 : FieldPoly N) + ∑ g, ((β g : ℝ) : ℂ) • X (μ, g)





/-- The coefficient polynomials of the Gauss-law vector field: (minus) the infinitesimal gauge
transformation of the coordinate `A_{μa}` generated by `T_c`. -/
def gaussVec (c : Fin N) : (Fin 4 × Fin N) → FieldPoly N := fun i =>
  vecComb (-(G.D i.1 c i.2)) (fun g => G.f i.2 g c) i.1

/-- The Gauss-law generator as a derivation of the field algebra. -/
def gaussDer (c : Fin N) : Derivation ℂ (FieldPoly N) (FieldPoly N) :=
  mkDerivation ℂ (gaussVec G c)

@[simp] theorem gaussDer_X (c : Fin N) (i : Fin 4 × Fin N) :
    gaussDer G c (X i) = gaussVec G c i := mkDerivation_X ℂ _ i







/-- **The Gauss-law constraint** `𝒢_c` on the polynomial core. -/
def gaussGenPoly (c : Fin N) : Module.End ℂ (FieldPoly N) := (gaussDer G c).toLinearMap



/-- **The Gauss-law constraint** `𝒢_c` on the graded state space. -/
def gaussGen (c : Fin N) : Module.End ℂ (BookState N) := bosOpN (gaussGenPoly G c)







A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab},   {ψ_a, ψ†_b} = δ_{ab},   {ψ_a,ψ_b} = {ψ†_a,ψ†_b} = 0 .
```

This module builds that charge: the three terms above, with the momenta, gauge-field
multiplication operators and ghosts realized as operators on a concrete graded state space,
and it *derives* the constraint algebra — the Gauss law — from the canonical relations
instead of assuming it.

## The gauge algebra and the derivative term

The book's gauge field takes values in the Lie algebra of the gauge group at every point of
space.  Here the local gauge algebra is modelled by a finite-dimensional Lie algebra `𝔤`
(basis `T_a`, `a : Fin N`, structure constants `f_{abc}` totally antisymmetric, as for the
book's `SU(N)` generators normalized by `tr(T_aT_b) = ½δ_{ab}`) carrying, for each spacetime
direction `μ`, a **derivation** `∂_μ` (matrix `D μ`).  The derivation property
`∂_μ[X,Y] = [∂_μX,Y] + [X,∂_μY]` is exactly what makes the first term `π^μ_a ∂_μψ†_a` of the
book's charge enter the Gauss-law algebra correctly.  `∂_μ = 0` is the constant
(single-multiplet) case; `∂_μ = ad_{X_μ}` is a non-trivial instance, exhibited below.

## What is proved

* `bookCCR`, `bookGhostCar` — the canonical (anti)commutation relations of the book's section
  hold in the realization: `[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`, `{ψ_a, ψ†_b} = δ_{ab}`, and the
  bosonic and ghost operators commute.
* `gaussGen_bracket` — **the Gauss-law constraint algebra**: the operators `𝒢_c` appearing as
  the coefficient of the ghost `ψ†_c` in the book's charge close into the gauge algebra,
  `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`.  This is *derived* from the canonical relations, the
  derivation property of `∂_μ` and the Jacobi identity.
* `bookOmega_eq_brstCharge` — the book's charge is `i` times the abstract BRST charge of
  `BookProof.QuantumGravityBrstCharge` with these constraints; in particular the coefficient
  `−i/2` of the cubic ghost term of `book.tex` is exactly the one nilpotency requires.
* **`bookOmega_nilpotent`** — `Ω² = 0` for the book's charge.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.BookBrstYangMills

open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

/-! ## 1. The gauge algebra with its spacetime derivations -/

/-- The data of the book's gauge algebra: totally antisymmetric structure constants obeying
the Jacobi identity (the `SU(N)` structure constants of the book's §"Pure SU(3) Yang-Mills
theory"), together with the four spacetime derivations `∂_μ` in the same basis,
`∂_μ T_a = Σ_b (D μ)_{ab} T_b`. -/
structure GaugeAlgebra (N : ℕ) where
  /-- structure constants, `[T_a, T_b] = Σ_c f_{abc} T_c` -/
  f : Fin N → Fin N → Fin N → ℝ
  /-- antisymmetry in the first two indices -/
  antisymm : ∀ a b c, f a b c = -f b a c
  /-- cyclic invariance; together with `antisymm` this is total antisymmetry, which is what
  the book's normalization `tr(T_aT_b) = ½δ_{ab}` provides -/
  cyclic : ∀ a b c, f a b c = f b c a
  /-- the Jacobi identity -/
  jacobi : ∀ a b c d, ∑ e, (f a b e * f e c d + f b c e * f e a d + f c a e * f e b d) = 0
  /-- the spacetime derivatives in the basis: `∂_μ T_a = Σ_b (D μ)_{ab} T_b` -/
  D : Fin 4 → Fin N → Fin N → ℝ
  /-- `∂_μ` is a derivation: `∂_μ[T_a,T_b] = [∂_μT_a, T_b] + [T_a, ∂_μT_b]` -/
  leibniz : ∀ μ a b c, ∑ h, f a b h * D μ h c
    = ∑ h, D μ a h * f h b c + ∑ h, D μ b h * f a h c

variable {N : ℕ} (G : GaugeAlgebra N)

/-! ## 2. Two index identities of the gauge algebra -/

/-- The contracted product of two structure constants. -/
def strProd (p q r s : Fin N) : ℝ := ∑ m, G.f p q m * G.f r s m

theorem strProd_symm (p q r s : Fin N) : strProd G p q r s = strProd G r s p q :=
  Finset.sum_congr rfl fun _ _ => mul_comm _ _

theorem strProd_swap12 (p q r s : Fin N) : strProd G p q r s = -strProd G q p r s := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm p q m]; ring

theorem strProd_swap34 (p q r s : Fin N) : strProd G p q r s = -strProd G p q s r := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm r s m]; ring

/-- The Jacobi identity in contracted form. -/
theorem strProd_jacobi (x y z w : Fin N) :
    strProd G x y z w + strProd G y z x w + strProd G z x y w = 0 := by
  have h := G.jacobi x y z w
  rw [← h]
  simp only [strProd]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [G.cyclic m z w, G.cyclic m x w, G.cyclic m y w]

/-- **Constant part of the Gauss-law closure**: the derivation property of `∂_μ`. -/
theorem gauss_const_identity (μ : Fin 4) (a c e : Fin N) :
    (∑ b, G.f a b e * (-(G.D μ c b))) - (∑ b, G.f a b c * (-(G.D μ e b)))
      = ∑ h, G.f c e h * (-(G.D μ h a)) := by
  have hl := G.leibniz μ c e a
  have e1 : ∀ h : Fin N, G.D μ c h * G.f h e a = G.f a h e * G.D μ c h := by
    intro h
    have : G.f h e a = G.f a h e := by rw [G.cyclic h e a, G.cyclic e a h]
    rw [this, mul_comm]
  have e2 : ∀ h : Fin N, G.D μ e h * G.f c h a = -(G.f a h c * G.D μ e h) := by
    intro h
    have : G.f c h a = -G.f a h c := by rw [G.cyclic c h a, G.antisymm h a c]
    rw [this]; ring
  have hR : ∑ h, G.f c e h * (-(G.D μ h a)) = -(∑ h, G.f c e h * G.D μ h a) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => by ring
  have s1 : ∑ b, G.f a b e * (-(G.D μ c b)) = -(∑ b, G.f a b e * G.D μ c b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s2 : ∑ b, G.f a b c * (-(G.D μ e b)) = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s3 : ∑ h, G.D μ c h * G.f h e a = ∑ b, G.f a b e * G.D μ c b :=
    Finset.sum_congr rfl fun h _ => e1 h
  have s4 : ∑ h, G.D μ e h * G.f c h a = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => e2 h
  rw [hR, hl, s1, s2, s3, s4]
  ring

/-- **Field-dependent part of the Gauss-law closure**: the Jacobi identity. -/
theorem gauss_field_identity (a c e g : Fin N) :
    (∑ b, G.f a b e * G.f b g c) - (∑ b, G.f a b c * G.f b g e)
      = ∑ h, G.f c e h * G.f a g h := by
  have t1 : (∑ b, G.f a b e * G.f b g c) = strProd G e a g c := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b e, G.cyclic b e a, G.cyclic b g c]
  have t2 : (∑ b, G.f a b c * G.f b g e) = strProd G c a g e := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b c, G.cyclic b c a, G.cyclic b g e]
  have t3 : (∑ h, G.f c e h * G.f a g h) = strProd G c e a g := rfl
  rw [t1, t2, t3]
  have J1 := strProd_jacobi G e a g c
  have J2 := strProd_jacobi G c a g e
  have J3 := strProd_jacobi G a c g e
  have r1 : strProd G a g e c = -strProd G a g c e := strProd_swap34 G a g e c
  have r2 : strProd G g e a c = strProd G a c g e := strProd_symm G g e a c
  have r3 : strProd G g c a e = -strProd G c g a e := strProd_swap12 G g c a e
  have r4 : strProd G g a c e = -strProd G a g c e := strProd_swap12 G g a c e
  have r5 : strProd G c e a g = strProd G a g c e := strProd_symm G c e a g
  rw [r5]
  linarith [J1, J2, J3, r1, r2, r3, r4]

/-! ## 3. The state space: fields and ghosts -/

/-- The bosonic field coordinates: one polynomial variable per gauge-field component
`A_{μa}`. -/
abbrev FieldPoly (N : ℕ) : Type := MvPolynomial (Fin 4 × Fin N) ℂ

/-- The ghost sector: the `ℤ₂^N` occupation space `Λ(ℂ^N)`, one ghost per gauge generator. -/
abbrev GhostSpace (N : ℕ) : Type := ExteriorAlgebra ℂ (Fin N → ℂ)

/-- The graded state space of the book's section: bosonic fields tensored with ghosts. -/
abbrev BookState (N : ℕ) : Type := TensorProduct ℂ (FieldPoly N) (GhostSpace N)

/-- The ghost creation operator `ψ†_a`. -/
def ghostCreN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  LinearMap.mulLeft ℂ (ExteriorAlgebra.ι ℂ (Pi.single a 1))

/-- The ghost annihilation operator `ψ_a`. -/
def ghostAnnN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  CliffordAlgebra.contractLeft (LinearMap.proj a)

theorem ghostN_car : GhostCAR (ghostCreN (N := N)) (ghostAnnN (N := N)) := by
  constructor
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.mulLeft_apply,
      LinearMap.zero_apply, ← mul_assoc]
    rw [← add_mul, CliffordAlgebra.ι_mul_ι_add_swap]
    simp [QuadraticMap.polar]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostAnnN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply]
    rw [CliffordAlgebra.contractLeft_comm, neg_add_cancel]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, ghostAnnN, LinearMap.add_apply, Module.End.mul_apply,
      LinearMap.mulLeft_apply, CliffordAlgebra.contractLeft_ι_mul]
    by_cases h : a = b
    · subst h; simp
    · simp [h]

/-- A bosonic operator on the graded space. -/
def bosOpN (T : Module.End ℂ (FieldPoly N)) : Module.End ℂ (BookState N) :=
  LinearMap.rTensor (GhostSpace N) T

/-- A ghost operator on the graded space. -/
def ghostOpN (T : Module.End ℂ (GhostSpace N)) : Module.End ℂ (BookState N) :=
  LinearMap.lTensor (FieldPoly N) T

theorem bosOpN_mul (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S * T) = bosOpN S * bosOpN T := by
  simp [bosOpN, Module.End.mul_eq_comp, LinearMap.rTensor_comp]

theorem bosOpN_sub (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S - T) = bosOpN S - bosOpN T := by simp [bosOpN]

theorem bosOpN_one : bosOpN (1 : Module.End ℂ (FieldPoly N)) = 1 := by
  simp [bosOpN, Module.End.one_eq_id, LinearMap.rTensor_id]

theorem bosOpN_zero : bosOpN (0 : Module.End ℂ (FieldPoly N)) = 0 := by simp [bosOpN]

theorem bosOpN_smul (r : ℂ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by
  refine LinearMap.ext fun x => ?_
  induction x using TensorProduct.induction_on with
  | zero => simp
  | tmul a b => simp [bosOpN, TensorProduct.smul_tmul']
  | add x y hx hy => simp [hx, hy]

theorem bosOpN_rsmul (r : ℝ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by
  have h1 : (r : ℝ) • T = ((r : ℂ)) • T := by
    ext p
    simp [Complex.real_smul]
  have h2 : ((r : ℂ)) • bosOpN T = (r : ℝ) • bosOpN T := by
    ext x
    first
      | exact algebraMap_smul ℂ r (bosOpN T _)
      | exact (algebraMap_smul ℂ r (bosOpN T _)).symm
      | rfl
  rw [h1, bosOpN_smul, h2]

theorem bosOpN_sum {n : ℕ} (T : Fin n → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ e, T e) = ∑ e, bosOpN (T e) :=
  map_sum (LinearMap.rTensorHom (R := ℂ) (GhostSpace N)) T Finset.univ

theorem ghostOpN_mul (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S * T) = ghostOpN S * ghostOpN T := by
  simp [ghostOpN, Module.End.mul_eq_comp, LinearMap.lTensor_comp]

theorem ghostOpN_add (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S + T) = ghostOpN S + ghostOpN T := by simp [ghostOpN]

theorem ghostOpN_one : ghostOpN (1 : Module.End ℂ (GhostSpace N)) = 1 := by
  simp [ghostOpN, Module.End.one_eq_id, LinearMap.lTensor_id]

theorem ghostOpN_zero : ghostOpN (0 : Module.End ℂ (GhostSpace N)) = 0 := by simp [ghostOpN]

theorem bosOpN_ghostOpN_comm (S : Module.End ℂ (FieldPoly N)) (T : Module.End ℂ (GhostSpace N)) :
    bosOpN S * ghostOpN T = ghostOpN T * bosOpN S := by
  simp [bosOpN, ghostOpN, Module.End.mul_eq_comp, LinearMap.lTensor_comp_rTensor,
    LinearMap.rTensor_comp_lTensor]

/-- The ghost creation operator `ψ†_a` on the graded space. -/
def chiOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostCreN a)

/-- The ghost annihilation operator `ψ_a` on the graded space. -/
def betaOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostAnnN a)

/-- **The ghosts of the book's section obey the canonical anticommutation relations.** -/
theorem bookGhostCar : GhostCAR (chiOp (N := N)) (betaOp (N := N)) := by
  classical
  constructor
  · intro a b
    rw [chiOp, chiOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).chichi a b, ghostOpN_zero]
  · intro a b
    rw [betaOp, betaOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).betabeta a b, ghostOpN_zero]
  · intro a b
    rw [betaOp, chiOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).betachi a b]
    by_cases h : a = b
    · simp [h, ghostOpN_one]
    · simp [h, ghostOpN_zero]

/-! ## 4. The gauge field and its conjugate momentum -/

/-- The gauge-field operator `A_{μa}` on the polynomial core: multiplication by the
coordinate. -/
def AfieldPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  LinearMap.mulLeft ℂ (X (μ, a))

/-- The conjugate momentum `π^μ_a = −i ∂/∂A_{μa}` on the polynomial core. -/
def momPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  (-Complex.I) • (pderiv (μ, a) : Derivation ℂ (FieldPoly N) (FieldPoly N)).toLinearMap

/-- The gauge-field operator on the graded space. -/
def Afield (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (AfieldPoly μ a)

/-- The conjugate momentum on the graded space. -/
def mom (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (momPoly μ a)

theorem momPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    momPoly μ a p = (-Complex.I) • (pderiv (μ, a) p) := rfl

theorem AfieldPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    AfieldPoly μ a p = X (μ, a) * p := rfl

/-- **The canonical commutation relation of the book's section** on the polynomial core:
`[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`. -/
theorem bookCCR_poly (μ ν : Fin 4) (a b : Fin N) :
    AfieldPoly μ a * momPoly ν b - momPoly ν b * AfieldPoly μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (FieldPoly N)) else 0 := by
  classical
  refine LinearMap.ext fun p => ?_
  have hd : (pderiv (ν, b) : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X (μ, a) * p)
      = (if (ν, b) = (μ, a) then p else 0) + X (μ, a) * pderiv (ν, b) p := by
    rw [Derivation.leibniz]
    simp only [MvPolynomial.pderiv_X, Pi.single_apply]
    by_cases h : (ν, b) = (μ, a)
    · rw [if_pos h, if_pos h.symm]
      simp [add_comm]
    · rw [if_neg h, if_neg (fun hc => h hc.symm)]
      simp
  by_cases h : (μ, a) = (ν, b)
  · have h' : (ν, b) = (μ, a) := h.symm
    simp only [if_pos h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_pos h', LinearMap.smul_apply, Module.End.one_apply, smul_add,
      mul_smul_comm]
    rw [h]
    simp
  · have h' : ¬ (ν, b) = (μ, a) := fun hc => h hc.symm
    simp only [if_neg h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_neg h', LinearMap.zero_apply, zero_add, 
      mul_smul_comm]
    simp

/-- **The canonical commutation relation** on the graded state space. -/
theorem bookCCR (μ ν : Fin 4) (a b : Fin N) :
    Afield μ a * mom ν b - mom ν b * Afield μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (BookState N)) else 0 := by
  classical
  rw [Afield, mom, ← bosOpN_mul, ← bosOpN_mul, ← bosOpN_sub, bookCCR_poly]
  by_cases h : (μ, a) = (ν, b)
  · rw [if_pos h, if_pos h, bosOpN_smul, bosOpN_one]
  · rw [if_neg h, if_neg h, bosOpN_zero]

/-- The bosonic operators commute with the ghosts. -/
theorem Afield_comm_chi (μ : Fin 4) (a b : Fin N) :
    Afield (N := N) μ a * chiOp b = chiOp b * Afield μ a := bosOpN_ghostOpN_comm _ _

theorem mom_comm_chi (μ : Fin 4) (a b : Fin N) :
    mom (N := N) μ a * chiOp b = chiOp b * mom μ a := bosOpN_ghostOpN_comm _ _

/-! ## 5. The Gauss-law constraints -/

/-- An affine combination `α·1 + Σ_g β_g A_{μg}` of the field coordinates in one spacetime
direction: the shape of an infinitesimal gauge transformation of `A_{μa}`. -/
def vecComb (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) : FieldPoly N :=
  ((α : ℝ) : ℂ) • (1 : FieldPoly N) + ∑ g, ((β g : ℝ) : ℂ) • X (μ, g)

theorem vecComb_sub (α α' : ℝ) (β β' : Fin N → ℝ) (μ : Fin 4) :
    vecComb α β μ - vecComb α' β' μ = vecComb (α - α') (fun g => β g - β' g) μ := by
  simp only [vecComb, Complex.ofReal_sub, sub_smul, Finset.sum_sub_distrib]
  abel

theorem vecComb_sum {n : ℕ} (κ : Fin n → ℝ) (α : Fin n → ℝ) (β : Fin n → Fin N → ℝ)
    (μ : Fin 4) :
    (∑ h, ((κ h : ℝ) : ℂ) • vecComb (α h) (β h) μ)
      = vecComb (∑ h, κ h * α h) (fun g => ∑ h, κ h * β h g) μ := by
  simp only [vecComb, smul_add, Finset.smul_sum, smul_smul, ← Complex.ofReal_mul]
  rw [Finset.sum_add_distrib, ← Finset.sum_smul, ← Complex.ofReal_sum]
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun g _ => ?_
  rw [← Finset.sum_smul, ← Complex.ofReal_sum]

/-- The coefficient polynomials of the Gauss-law vector field: (minus) the infinitesimal gauge
transformation of the coordinate `A_{μa}` generated by `T_c`. -/
def gaussVec (c : Fin N) : (Fin 4 × Fin N) → FieldPoly N := fun i =>
  vecComb (-(G.D i.1 c i.2)) (fun g => G.f i.2 g c) i.1

/-- The Gauss-law generator as a derivation of the field algebra. -/
def gaussDer (c : Fin N) : Derivation ℂ (FieldPoly N) (FieldPoly N) :=
  mkDerivation ℂ (gaussVec G c)

@[simp] theorem gaussDer_X (c : Fin N) (i : Fin 4 × Fin N) :
    gaussDer G c (X i) = gaussVec G c i := mkDerivation_X ℂ _ i

/-- The action of a Gauss-law generator on an affine combination of coordinates. -/
theorem gaussDer_vecComb (c : Fin N) (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) :
    gaussDer G c (vecComb α β μ)
      = vecComb (∑ b, β b * (-(G.D μ c b))) (fun g => ∑ b, β b * G.f b g c) μ := by
  have h1 : gaussDer G c (((α : ℝ) : ℂ) • (1 : FieldPoly N)) = 0 := by
    rw [Derivation.map_smul_of_tower, Derivation.map_one_eq_zero, smul_zero]
  have h2 : gaussDer G c (∑ g, ((β g : ℝ) : ℂ) • X (μ, g))
      = ∑ g, ((β g : ℝ) : ℂ) • gaussVec G c (μ, g) := by
    rw [map_sum]
    exact Finset.sum_congr rfl fun g _ => by
      rw [Derivation.map_smul_of_tower, gaussDer_X]
  rw [vecComb, map_add, h1, h2, zero_add]
  simpa [gaussVec] using vecComb_sum (N := N) β (fun b => -(G.D μ c b))
    (fun b g => G.f b g c) μ

/-- Applying a linear combination of derivations. -/
theorem sum_smul_der_apply {n : ℕ} (k : Fin n → ℂ)
    (D : Fin n → Derivation ℂ (FieldPoly N) (FieldPoly N)) (p : FieldPoly N) :
    (∑ h, k h • D h) p = ∑ h, k h • (D h) p := by
  classical
  induction (Finset.univ : Finset (Fin n)) using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Derivation.add_apply,
        Derivation.smul_apply, ih]

/-- **The Gauss-law constraints close into the gauge algebra** (as derivations of the field
algebra): `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`. -/
theorem gaussDer_bracket (c e : Fin N) :
    ⁅gaussDer G c, gaussDer G e⁆
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h := by
  refine MvPolynomial.derivation_ext fun i => ?_
  obtain ⟨μ, a⟩ := i
  have hsum : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) (X (μ, a))
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • gaussVec G h (μ, a) := by
    have hstep : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) (X (μ, a))
        = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) (X (μ, a)) :=
      sum_smul_der_apply _ _ _
    rw [hstep]
    exact Finset.sum_congr rfl fun h _ => by rw [gaussDer_X]
  rw [Derivation.commutator_apply, hsum, gaussDer_X, gaussDer_X, gaussVec, gaussVec,
    gaussDer_vecComb, gaussDer_vecComb, vecComb_sub]
  have hR : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussVec G h (μ, a))
      = vecComb (∑ h, G.f c e h * (-(G.D μ h a)))
          (fun g => ∑ h, G.f c e h * G.f a g h) μ := by
    simpa [gaussVec] using vecComb_sum (N := N) (fun h => G.f c e h)
      (fun h => -(G.D μ h a)) (fun h g => G.f a g h) μ
  rw [hR]
  congr 1
  · exact gauss_const_identity G μ a c e
  · funext g
    exact gauss_field_identity G a c e g

/-- **The Gauss-law constraint** `𝒢_c` on the polynomial core. -/
def gaussGenPoly (c : Fin N) : Module.End ℂ (FieldPoly N) := (gaussDer G c).toLinearMap

theorem gaussGenPoly_bracket (c e : Fin N) :
    gaussGenPoly G c * gaussGenPoly G e - gaussGenPoly G e * gaussGenPoly G c
      = ∑ h, (G.f c e h) • gaussGenPoly G h := by
  refine LinearMap.ext fun p => ?_
  have h := congrArg (fun D : Derivation ℂ (FieldPoly N) (FieldPoly N) => D p)
    (gaussDer_bracket G c e)
  simp only [Derivation.commutator_apply] at h
  have hR : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) p
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) p := sum_smul_der_apply _ _ _
  rw [hR] at h
  calc (gaussGenPoly G c * gaussGenPoly G e - gaussGenPoly G e * gaussGenPoly G c) p
      = (gaussDer G c) ((gaussDer G e) p) - (gaussDer G e) ((gaussDer G c) p) := rfl
    _ = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) p := h
    _ = (∑ h, (G.f c e h) • gaussGenPoly G h) p := by
        rw [LinearMap.sum_apply]
        exact Finset.sum_congr rfl fun h _ => by
          simp [gaussGenPoly]

/-- **The Gauss-law constraint** `𝒢_c` on the graded state space. -/
def gaussGen (c : Fin N) : Module.End ℂ (BookState N) := bosOpN (gaussGenPoly G c)

theorem gaussGen_bracket (c e : Fin N) :
    gaussGen G c * gaussGen G e - gaussGen G e * gaussGen G c
      = ∑ h, (G.f c e h) • gaussGen G h := by
  rw [gaussGen, gaussGen, ← bosOpN_mul, ← bosOpN_mul, ← bosOpN_sub, gaussGenPoly_bracket,
    bosOpN_sum]
  exact Finset.sum_congr rfl fun h _ => bosOpN_rsmul _ _

/-- The action of a Gauss-law generator on an arbitrary polynomial. -/
theorem gaussDer_apply (c : Fin N) (p : FieldPoly N) :
    gaussDer G c p = ∑ i : Fin 4 × Fin N, gaussVec G c i * pderiv i p := by
  classical
  induction p using MvPolynomial.induction_on with
  | C a =>
      rw [show (C a : FieldPoly N) = algebraMap ℂ (FieldPoly N) a from rfl,
        Derivation.map_algebraMap]
      simp
  | add p q hp hq =>
      rw [map_add, hp, hq, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun i _ => by rw [map_add, mul_add]
  | mul_X p i hp =>
      rw [Derivation.leibniz, hp, gaussDer_X]
      have hstep : ∀ j : Fin 4 × Fin N,
          gaussVec G c j * pderiv j (p * X i)
            = gaussVec G c j * pderiv j p * X i + (if j = i then gaussVec G c j * p else 0) := by
        intro j
        rw [Derivation.leibniz, MvPolynomial.pderiv_X]
        by_cases h : j = i
        · subst h
          simp [mul_add, mul_comm, mul_left_comm]
          ring
        · simp [h, mul_comm, mul_left_comm]
      rw [Finset.sum_congr rfl fun j _ => hstep j, Finset.sum_add_distrib,
        Finset.sum_ite_eq' Finset.univ i (fun j => gaussVec G c j * p)]
      simp only [Finset.mem_univ, if_pos, smul_eq_mul, Finset.mul_sum]
      rw [add_comm]
      congr 1
      · exact Finset.sum_congr rfl fun x _ => by ring
      · ring

/-- Leibniz rule against a coordinate. -/
theorem pderiv_X_mul (i j : Fin 4 × Fin N) (p : FieldPoly N) :
    (pderiv i : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X j * p)
      = (if i = j then p else 0) + X j * pderiv i p := by
  classical
  rw [Derivation.leibniz]
  simp only [MvPolynomial.pderiv_X, Pi.single_apply]
  by_cases h : i = j
  · subst h; simp; ring
  · rw [if_neg h, if_neg (fun hc => h hc.symm)]
    simp

/-- The Gauss-law constraint written with the book's momenta and gauge fields:
`𝒢_c = −i(π^μ_a ∂_μT_c|_a − f_{abc} π^μ_a A_{μb})`, i.e. `−i` times the coefficient of the
ghost `ψ†_c` in the book's charge. -/
theorem gaussGenPoly_eq (c : Fin N) :
    gaussGenPoly G c = (-Complex.I) •
      ((∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • momPoly μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b))) := by
  classical
  refine LinearMap.ext fun p => ?_
  have hL : gaussGenPoly G c p = ∑ μ, ∑ a, gaussVec G c (μ, a) * pderiv (μ, a) p := by
    have h0 : gaussGenPoly G c p = gaussDer G c p := rfl
    rw [h0, gaussDer_apply]
    exact Fintype.sum_prod_type _
  have hterm : ∀ (μ : Fin 4) (a : Fin N),
      gaussVec G c (μ, a) * pderiv (μ, a) p
        = (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) • momPoly μ a) p
            - ∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p) := by
    intro μ a
    have hb : ∀ b : Fin N,
        (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p
          = ((G.f a b c : ℝ) : ℂ) • ((-Complex.I) •
              ((if (μ, a) = (μ, b) then p else 0) + X (μ, b) * pderiv (μ, a) p)) := by
      intro b
      simp only [LinearMap.smul_apply, Module.End.mul_apply, AfieldPoly_apply, momPoly_apply,
        pderiv_X_mul]
    have hdiag : ((G.f a a c : ℝ) : ℂ) = 0 := by
      have : G.f a a c = 0 := by
        have h := G.antisymm a a c
        linarith
      rw [this]
      simp
    have hsum : (∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p)
        = ∑ b, ((G.f a b c : ℝ) : ℂ) • ((-Complex.I) • (X (μ, b) * pderiv (μ, a) p)) := by
      rw [Finset.sum_congr rfl fun b _ => hb b]
      refine Finset.sum_congr rfl fun b _ => ?_
      by_cases h : a = b
      · subst h
        rw [hdiag]
        simp
      · have h' : ¬ ((μ, a) = (μ, b)) := by
          intro hc
          exact h (congrArg Prod.snd hc)
        rw [if_neg h']
        simp
    rw [hsum]
    simp only [LinearMap.smul_apply, momPoly_apply, gaussVec, vecComb, smul_smul]
    rw [add_mul, Finset.sum_mul]
    simp only [smul_mul_assoc, one_mul, Complex.ofReal_neg]
    rw [smul_sub, Finset.smul_sum]
    have hIz : ∀ z : ℂ, -Complex.I * (z * -Complex.I) = -z := fun z => by
      linear_combination z * Complex.I_sq
    have hx : ∀ x : Fin N,
        (-Complex.I) • ((((G.f a x c : ℝ) : ℂ) * -Complex.I) • (X (μ, x) * pderiv (μ, a) p))
          = -((((G.f a x c : ℝ) : ℂ)) • (X (μ, x) * pderiv (μ, a) p)) := by
      intro x
      rw [smul_smul, hIz, neg_smul]
    have hd0 : (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) * -Complex.I) • (pderiv (μ, a) p))
        = -((((G.D μ c a : ℝ) : ℂ)) • (pderiv (μ, a) p)) := by
      rw [smul_smul, hIz, neg_smul]
    rw [hd0, Finset.sum_congr rfl fun x _ => hx x, Finset.sum_neg_distrib, sub_neg_eq_add,
      neg_smul]
  have hR : ((-Complex.I) •
      ((∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • momPoly μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)))) p
      = ∑ μ, ∑ a, (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) • momPoly μ a) p
          - ∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p) := by
    simp only [LinearMap.smul_apply, LinearMap.sub_apply, LinearMap.sum_apply, smul_sub,
      Finset.smul_sum, ← Finset.sum_sub_distrib]
  rw [hL, hR]
  exact Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => hterm μ a

/-! ## 6. The book's BRST charge -/

/-- `∂_μψ†_a`, the `a`-component of the spacetime derivative of the ghost field. -/
def dChi (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) :=
  ∑ b, (G.D μ b a) • chiOp b

/-- **The BRST charge of `book.tex`**,
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc} A_{μb} ψ†_c − (i/2) f_{abc} ψ†_a ψ†_b ψ_c`. -/
def bookOmega : Module.End ℂ (BookState N) :=
  (∑ μ, ∑ a, mom μ a * dChi G μ a)
    - (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c))
    - (Complex.I / 2) • (∑ a, ∑ b, ∑ c, (G.f a b c) • (chiOp a * chiOp b * betaOp c))

/-- The book's charge is `i` times the abstract BRST charge with the Gauss-law constraints;
in particular the book's coefficient `−i/2` of the cubic ghost term is exactly the one that
nilpotency requires. -/
theorem rsmul_eq_csmul (r : ℝ) (T : Module.End ℂ (BookState N)) :
    r • T = ((r : ℝ) : ℂ) • T := by
  refine LinearMap.ext fun x => ?_
  simp only [LinearMap.smul_apply]
  exact (algebraMap_smul ℂ r (T x)).symm







b} = 0 .
```

This module builds that charge: the three terms above, with the momenta, gauge-field
multiplication operators and ghosts realized as operators on a concrete graded state space,
and it *derives* the constraint algebra — the Gauss law — from the canonical relations
instead of assuming it.

## The gauge algebra and the derivative term

The book's gauge field takes values in the Lie algebra of the gauge group at every point of
space.  Here the local gauge algebra is modelled by a finite-dimensional Lie algebra `𝔤`
(basis `T_a`, `a : Fin N`, structure constants `f_{abc}` totally antisymmetric, as for the
book's `SU(N)` generators normalized by `tr(T_aT_b) = ½δ_{ab}`) carrying, for each spacetime
direction `μ`, a **derivation** `∂_μ` (matrix `D μ`).  The derivation property
`∂_μ[X,Y] = [∂_μX,Y] + [X,∂_μY]` is exactly what makes the first term `π^μ_a ∂_μψ†_a` of the
book's charge enter the Gauss-law algebra correctly.  `∂_μ = 0` is the constant
(single-multiplet) case; `∂_μ = ad_{X_μ}` is a non-trivial instance, exhibited below.

## What is proved

* `bookCCR`, `bookGhostCar` — the canonical (anti)commutation relations of the book's section
  hold in the realization: `[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`, `{ψ_a, ψ†_b} = δ_{ab}`, and the
  bosonic and ghost operators commute.
* `gaussGen_bracket` — **the Gauss-law constraint algebra**: the operators `𝒢_c` appearing as
  the coefficient of the ghost `ψ†_c` in the book's charge close into the gauge algebra,
  `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`.  This is *derived* from the canonical relations, the
  derivation property of `∂_μ` and the Jacobi identity.
* `bookOmega_eq_brstCharge` — the book's charge is `i` times the abstract BRST charge of
  `BookProof.QuantumGravityBrstCharge` with these constraints; in particular the coefficient
  `−i/2` of the cubic ghost term of `book.tex` is exactly the one nilpotency requires.
* **`bookOmega_nilpotent`** — `Ω² = 0` for the book's charge.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.BookBrstYangMills

open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

/-! ## 1. The gauge algebra with its spacetime derivations -/

/-- The data of the book's gauge algebra: totally antisymmetric structure constants obeying
the Jacobi identity (the `SU(N)` structure constants of the book's §"Pure SU(3) Yang-Mills
theory"), together with the four spacetime derivations `∂_μ` in the same basis,
`∂_μ T_a = Σ_b (D μ)_{ab} T_b`. -/
structure GaugeAlgebra (N : ℕ) where
  /-- structure constants, `[T_a, T_b] = Σ_c f_{abc} T_c` -/
  f : Fin N → Fin N → Fin N → ℝ
  /-- antisymmetry in the first two indices -/
  antisymm : ∀ a b c, f a b c = -f b a c
  /-- cyclic invariance; together with `antisymm` this is total antisymmetry, which is what
  the book's normalization `tr(T_aT_b) = ½δ_{ab}` provides -/
  cyclic : ∀ a b c, f a b c = f b c a
  /-- the Jacobi identity -/
  jacobi : ∀ a b c d, ∑ e, (f a b e * f e c d + f b c e * f e a d + f c a e * f e b d) = 0
  /-- the spacetime derivatives in the basis: `∂_μ T_a = Σ_b (D μ)_{ab} T_b` -/
  D : Fin 4 → Fin N → Fin N → ℝ
  /-- `∂_μ` is a derivation: `∂_μ[T_a,T_b] = [∂_μT_a, T_b] + [T_a, ∂_μT_b]` -/
  leibniz : ∀ μ a b c, ∑ h, f a b h * D μ h c
    = ∑ h, D μ a h * f h b c + ∑ h, D μ b h * f a h c

variable {N : ℕ} (G : GaugeAlgebra N)

/-! ## 2. Two index identities of the gauge algebra -/

/-- The contracted product of two structure constants. -/
def strProd (p q r s : Fin N) : ℝ := ∑ m, G.f p q m * G.f r s m

theorem strProd_symm (p q r s : Fin N) : strProd G p q r s = strProd G r s p q :=
  Finset.sum_congr rfl fun _ _ => mul_comm _ _

theorem strProd_swap12 (p q r s : Fin N) : strProd G p q r s = -strProd G q p r s := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm p q m]; ring

theorem strProd_swap34 (p q r s : Fin N) : strProd G p q r s = -strProd G p q s r := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm r s m]; ring

/-- The Jacobi identity in contracted form. -/
theorem strProd_jacobi (x y z w : Fin N) :
    strProd G x y z w + strProd G y z x w + strProd G z x y w = 0 := by
  have h := G.jacobi x y z w
  rw [← h]
  simp only [strProd]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [G.cyclic m z w, G.cyclic m x w, G.cyclic m y w]

/-- **Constant part of the Gauss-law closure**: the derivation property of `∂_μ`. -/
theorem gauss_const_identity (μ : Fin 4) (a c e : Fin N) :
    (∑ b, G.f a b e * (-(G.D μ c b))) - (∑ b, G.f a b c * (-(G.D μ e b)))
      = ∑ h, G.f c e h * (-(G.D μ h a)) := by
  have hl := G.leibniz μ c e a
  have e1 : ∀ h : Fin N, G.D μ c h * G.f h e a = G.f a h e * G.D μ c h := by
    intro h
    have : G.f h e a = G.f a h e := by rw [G.cyclic h e a, G.cyclic e a h]
    rw [this, mul_comm]
  have e2 : ∀ h : Fin N, G.D μ e h * G.f c h a = -(G.f a h c * G.D μ e h) := by
    intro h
    have : G.f c h a = -G.f a h c := by rw [G.cyclic c h a, G.antisymm h a c]
    rw [this]; ring
  have hR : ∑ h, G.f c e h * (-(G.D μ h a)) = -(∑ h, G.f c e h * G.D μ h a) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => by ring
  have s1 : ∑ b, G.f a b e * (-(G.D μ c b)) = -(∑ b, G.f a b e * G.D μ c b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s2 : ∑ b, G.f a b c * (-(G.D μ e b)) = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s3 : ∑ h, G.D μ c h * G.f h e a = ∑ b, G.f a b e * G.D μ c b :=
    Finset.sum_congr rfl fun h _ => e1 h
  have s4 : ∑ h, G.D μ e h * G.f c h a = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => e2 h
  rw [hR, hl, s1, s2, s3, s4]
  ring

/-- **Field-dependent part of the Gauss-law closure**: the Jacobi identity. -/
theorem gauss_field_identity (a c e g : Fin N) :
    (∑ b, G.f a b e * G.f b g c) - (∑ b, G.f a b c * G.f b g e)
      = ∑ h, G.f c e h * G.f a g h := by
  have t1 : (∑ b, G.f a b e * G.f b g c) = strProd G e a g c := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b e, G.cyclic b e a, G.cyclic b g c]
  have t2 : (∑ b, G.f a b c * G.f b g e) = strProd G c a g e := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b c, G.cyclic b c a, G.cyclic b g e]
  have t3 : (∑ h, G.f c e h * G.f a g h) = strProd G c e a g := rfl
  rw [t1, t2, t3]
  have J1 := strProd_jacobi G e a g c
  have J2 := strProd_jacobi G c a g e
  have J3 := strProd_jacobi G a c g e
  have r1 : strProd G a g e c = -strProd G a g c e := strProd_swap34 G a g e c
  have r2 : strProd G g e a c = strProd G a c g e := strProd_symm G g e a c
  have r3 : strProd G g c a e = -strProd G c g a e := strProd_swap12 G g c a e
  have r4 : strProd G g a c e = -strProd G a g c e := strProd_swap12 G g a c e
  have r5 : strProd G c e a g = strProd G a g c e := strProd_symm G c e a g
  rw [r5]
  linarith [J1, J2, J3, r1, r2, r3, r4]

/-! ## 3. The state space: fields and ghosts -/

/-- The bosonic field coordinates: one polynomial variable per gauge-field component
`A_{μa}`. -/
abbrev FieldPoly (N : ℕ) : Type := MvPolynomial (Fin 4 × Fin N) ℂ

/-- The ghost sector: the `ℤ₂^N` occupation space `Λ(ℂ^N)`, one ghost per gauge generator. -/
abbrev GhostSpace (N : ℕ) : Type := ExteriorAlgebra ℂ (Fin N → ℂ)

/-- The graded state space of the book's section: bosonic fields tensored with ghosts. -/
abbrev BookState (N : ℕ) : Type := TensorProduct ℂ (FieldPoly N) (GhostSpace N)

/-- The ghost creation operator `ψ†_a`. -/
def ghostCreN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  LinearMap.mulLeft ℂ (ExteriorAlgebra.ι ℂ (Pi.single a 1))

/-- The ghost annihilation operator `ψ_a`. -/
def ghostAnnN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  CliffordAlgebra.contractLeft (LinearMap.proj a)

theorem ghostN_car : GhostCAR (ghostCreN (N := N)) (ghostAnnN (N := N)) := by
  constructor
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.mulLeft_apply,
      LinearMap.zero_apply, ← mul_assoc]
    rw [← add_mul, CliffordAlgebra.ι_mul_ι_add_swap]
    simp [QuadraticMap.polar]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostAnnN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply]
    rw [CliffordAlgebra.contractLeft_comm, neg_add_cancel]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, ghostAnnN, LinearMap.add_apply, Module.End.mul_apply,
      LinearMap.mulLeft_apply, CliffordAlgebra.contractLeft_ι_mul]
    by_cases h : a = b
    · subst h; simp
    · simp [h]

/-- A bosonic operator on the graded space. -/
def bosOpN (T : Module.End ℂ (FieldPoly N)) : Module.End ℂ (BookState N) :=
  LinearMap.rTensor (GhostSpace N) T

/-- A ghost operator on the graded space. -/
def ghostOpN (T : Module.End ℂ (GhostSpace N)) : Module.End ℂ (BookState N) :=
  LinearMap.lTensor (FieldPoly N) T

theorem bosOpN_mul (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S * T) = bosOpN S * bosOpN T := by
  simp [bosOpN, Module.End.mul_eq_comp, LinearMap.rTensor_comp]

theorem bosOpN_sub (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S - T) = bosOpN S - bosOpN T := by simp [bosOpN]

theorem bosOpN_one : bosOpN (1 : Module.End ℂ (FieldPoly N)) = 1 := by
  simp [bosOpN, Module.End.one_eq_id, LinearMap.rTensor_id]

theorem bosOpN_zero : bosOpN (0 : Module.End ℂ (FieldPoly N)) = 0 := by simp [bosOpN]

theorem bosOpN_smul (r : ℂ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by
  refine LinearMap.ext fun x => ?_
  induction x using TensorProduct.induction_on with
  | zero => simp
  | tmul a b => simp [bosOpN, TensorProduct.smul_tmul']
  | add x y hx hy => simp [hx, hy]

theorem bosOpN_rsmul (r : ℝ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by
  have h1 : (r : ℝ) • T = ((r : ℂ)) • T := by
    ext p
    simp [Complex.real_smul]
  have h2 : ((r : ℂ)) • bosOpN T = (r : ℝ) • bosOpN T := by
    ext x
    first
      | exact algebraMap_smul ℂ r (bosOpN T _)
      | exact (algebraMap_smul ℂ r (bosOpN T _)).symm
      | rfl
  rw [h1, bosOpN_smul, h2]

theorem bosOpN_sum {n : ℕ} (T : Fin n → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ e, T e) = ∑ e, bosOpN (T e) :=
  map_sum (LinearMap.rTensorHom (R := ℂ) (GhostSpace N)) T Finset.univ

theorem ghostOpN_mul (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S * T) = ghostOpN S * ghostOpN T := by
  simp [ghostOpN, Module.End.mul_eq_comp, LinearMap.lTensor_comp]

theorem ghostOpN_add (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S + T) = ghostOpN S + ghostOpN T := by simp [ghostOpN]

theorem ghostOpN_one : ghostOpN (1 : Module.End ℂ (GhostSpace N)) = 1 := by
  simp [ghostOpN, Module.End.one_eq_id, LinearMap.lTensor_id]

theorem ghostOpN_zero : ghostOpN (0 : Module.End ℂ (GhostSpace N)) = 0 := by simp [ghostOpN]

theorem bosOpN_ghostOpN_comm (S : Module.End ℂ (FieldPoly N)) (T : Module.End ℂ (GhostSpace N)) :
    bosOpN S * ghostOpN T = ghostOpN T * bosOpN S := by
  simp [bosOpN, ghostOpN, Module.End.mul_eq_comp, LinearMap.lTensor_comp_rTensor,
    LinearMap.rTensor_comp_lTensor]

/-- The ghost creation operator `ψ†_a` on the graded space. -/
def chiOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostCreN a)

/-- The ghost annihilation operator `ψ_a` on the graded space. -/
def betaOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostAnnN a)

/-- **The ghosts of the book's section obey the canonical anticommutation relations.** -/
theorem bookGhostCar : GhostCAR (chiOp (N := N)) (betaOp (N := N)) := by
  classical
  constructor
  · intro a b
    rw [chiOp, chiOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).chichi a b, ghostOpN_zero]
  · intro a b
    rw [betaOp, betaOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).betabeta a b, ghostOpN_zero]
  · intro a b
    rw [betaOp, chiOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).betachi a b]
    by_cases h : a = b
    · simp [h, ghostOpN_one]
    · simp [h, ghostOpN_zero]

/-! ## 4. The gauge field and its conjugate momentum -/

/-- The gauge-field operator `A_{μa}` on the polynomial core: multiplication by the
coordinate. -/
def AfieldPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  LinearMap.mulLeft ℂ (X (μ, a))

/-- The conjugate momentum `π^μ_a = −i ∂/∂A_{μa}` on the polynomial core. -/
def momPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  (-Complex.I) • (pderiv (μ, a) : Derivation ℂ (FieldPoly N) (FieldPoly N)).toLinearMap

/-- The gauge-field operator on the graded space. -/
def Afield (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (AfieldPoly μ a)

/-- The conjugate momentum on the graded space. -/
def mom (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (momPoly μ a)

theorem momPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    momPoly μ a p = (-Complex.I) • (pderiv (μ, a) p) := rfl

theorem AfieldPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    AfieldPoly μ a p = X (μ, a) * p := rfl

/-- **The canonical commutation relation of the book's section** on the polynomial core:
`[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`. -/
theorem bookCCR_poly (μ ν : Fin 4) (a b : Fin N) :
    AfieldPoly μ a * momPoly ν b - momPoly ν b * AfieldPoly μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (FieldPoly N)) else 0 := by
  classical
  refine LinearMap.ext fun p => ?_
  have hd : (pderiv (ν, b) : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X (μ, a) * p)
      = (if (ν, b) = (μ, a) then p else 0) + X (μ, a) * pderiv (ν, b) p := by
    rw [Derivation.leibniz]
    simp only [MvPolynomial.pderiv_X, Pi.single_apply]
    by_cases h : (ν, b) = (μ, a)
    · rw [if_pos h, if_pos h.symm]
      simp [add_comm]
    · rw [if_neg h, if_neg (fun hc => h hc.symm)]
      simp
  by_cases h : (μ, a) = (ν, b)
  · have h' : (ν, b) = (μ, a) := h.symm
    simp only [if_pos h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_pos h', LinearMap.smul_apply, Module.End.one_apply, smul_add,
      mul_smul_comm]
    rw [h]
    simp
  · have h' : ¬ (ν, b) = (μ, a) := fun hc => h hc.symm
    simp only [if_neg h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_neg h', LinearMap.zero_apply, zero_add, 
      mul_smul_comm]
    simp

/-- **The canonical commutation relation** on the graded state space. -/
theorem bookCCR (μ ν : Fin 4) (a b : Fin N) :
    Afield μ a * mom ν b - mom ν b * Afield μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (BookState N)) else 0 := by
  classical
  rw [Afield, mom, ← bosOpN_mul, ← bosOpN_mul, ← bosOpN_sub, bookCCR_poly]
  by_cases h : (μ, a) = (ν, b)
  · rw [if_pos h, if_pos h, bosOpN_smul, bosOpN_one]
  · rw [if_neg h, if_neg h, bosOpN_zero]

/-- The bosonic operators commute with the ghosts. -/
theorem Afield_comm_chi (μ : Fin 4) (a b : Fin N) :
    Afield (N := N) μ a * chiOp b = chiOp b * Afield μ a := bosOpN_ghostOpN_comm _ _

theorem mom_comm_chi (μ : Fin 4) (a b : Fin N) :
    mom (N := N) μ a * chiOp b = chiOp b * mom μ a := bosOpN_ghostOpN_comm _ _

/-! ## 5. The Gauss-law constraints -/

/-- An affine combination `α·1 + Σ_g β_g A_{μg}` of the field coordinates in one spacetime
direction: the shape of an infinitesimal gauge transformation of `A_{μa}`. -/
def vecComb (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) : FieldPoly N :=
  ((α : ℝ) : ℂ) • (1 : FieldPoly N) + ∑ g, ((β g : ℝ) : ℂ) • X (μ, g)

theorem vecComb_sub (α α' : ℝ) (β β' : Fin N → ℝ) (μ : Fin 4) :
    vecComb α β μ - vecComb α' β' μ = vecComb (α - α') (fun g => β g - β' g) μ := by
  simp only [vecComb, Complex.ofReal_sub, sub_smul, Finset.sum_sub_distrib]
  abel

theorem vecComb_sum {n : ℕ} (κ : Fin n → ℝ) (α : Fin n → ℝ) (β : Fin n → Fin N → ℝ)
    (μ : Fin 4) :
    (∑ h, ((κ h : ℝ) : ℂ) • vecComb (α h) (β h) μ)
      = vecComb (∑ h, κ h * α h) (fun g => ∑ h, κ h * β h g) μ := by
  simp only [vecComb, smul_add, Finset.smul_sum, smul_smul, ← Complex.ofReal_mul]
  rw [Finset.sum_add_distrib, ← Finset.sum_smul, ← Complex.ofReal_sum]
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun g _ => ?_
  rw [← Finset.sum_smul, ← Complex.ofReal_sum]

/-- The coefficient polynomials of the Gauss-law vector field: (minus) the infinitesimal gauge
transformation of the coordinate `A_{μa}` generated by `T_c`. -/
def gaussVec (c : Fin N) : (Fin 4 × Fin N) → FieldPoly N := fun i =>
  vecComb (-(G.D i.1 c i.2)) (fun g => G.f i.2 g c) i.1

/-- The Gauss-law generator as a derivation of the field algebra. -/
def gaussDer (c : Fin N) : Derivation ℂ (FieldPoly N) (FieldPoly N) :=
  mkDerivation ℂ (gaussVec G c)

@[simp] theorem gaussDer_X (c : Fin N) (i : Fin 4 × Fin N) :
    gaussDer G c (X i) = gaussVec G c i := mkDerivation_X ℂ _ i

/-- The action of a Gauss-law generator on an affine combination of coordinates. -/
theorem gaussDer_vecComb (c : Fin N) (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) :
    gaussDer G c (vecComb α β μ)
      = vecComb (∑ b, β b * (-(G.D μ c b))) (fun g => ∑ b, β b * G.f b g c) μ := by
  have h1 : gaussDer G c (((α : ℝ) : ℂ) • (1 : FieldPoly N)) = 0 := by
    rw [Derivation.map_smul_of_tower, Derivation.map_one_eq_zero, smul_zero]
  have h2 : gaussDer G c (∑ g, ((β g : ℝ) : ℂ) • X (μ, g))
      = ∑ g, ((β g : ℝ) : ℂ) • gaussVec G c (μ, g) := by
    rw [map_sum]
    exact Finset.sum_congr rfl fun g _ => by
      rw [Derivation.map_smul_of_tower, gaussDer_X]
  rw [vecComb, map_add, h1, h2, zero_add]
  simpa [gaussVec] using vecComb_sum (N := N) β (fun b => -(G.D μ c b))
    (fun b g => G.f b g c) μ

/-- Applying a linear combination of derivations. -/
theorem sum_smul_der_apply {n : ℕ} (k : Fin n → ℂ)
    (D : Fin n → Derivation ℂ (FieldPoly N) (FieldPoly N)) (p : FieldPoly N) :
    (∑ h, k h • D h) p = ∑ h, k h • (D h) p := by
  classical
  induction (Finset.univ : Finset (Fin n)) using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Derivation.add_apply,
        Derivation.smul_apply, ih]

/-- **The Gauss-law constraints close into the gauge algebra** (as derivations of the field
algebra): `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`. -/
theorem gaussDer_bracket (c e : Fin N) :
    ⁅gaussDer G c, gaussDer G e⁆
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h := by
  refine MvPolynomial.derivation_ext fun i => ?_
  obtain ⟨μ, a⟩ := i
  have hsum : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) (X (μ, a))
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • gaussVec G h (μ, a) := by
    have hstep : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) (X (μ, a))
        = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) (X (μ, a)) :=
      sum_smul_der_apply _ _ _
    rw [hstep]
    exact Finset.sum_congr rfl fun h _ => by rw [gaussDer_X]
  rw [Derivation.commutator_apply, hsum, gaussDer_X, gaussDer_X, gaussVec, gaussVec,
    gaussDer_vecComb, gaussDer_vecComb, vecComb_sub]
  have hR : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussVec G h (μ, a))
      = vecComb (∑ h, G.f c e h * (-(G.D μ h a)))
          (fun g => ∑ h, G.f c e h * G.f a g h) μ := by
    simpa [gaussVec] using vecComb_sum (N := N) (fun h => G.f c e h)
      (fun h => -(G.D μ h a)) (fun h g => G.f a g h) μ
  rw [hR]
  congr 1
  · exact gauss_const_identity G μ a c e
  · funext g
    exact gauss_field_identity G a c e g

/-- **The Gauss-law constraint** `𝒢_c` on the polynomial core. -/
def gaussGenPoly (c : Fin N) : Module.End ℂ (FieldPoly N) := (gaussDer G c).toLinearMap

theorem gaussGenPoly_bracket (c e : Fin N) :
    gaussGenPoly G c * gaussGenPoly G e - gaussGenPoly G e * gaussGenPoly G c
      = ∑ h, (G.f c e h) • gaussGenPoly G h := by
  refine LinearMap.ext fun p => ?_
  have h := congrArg (fun D : Derivation ℂ (FieldPoly N) (FieldPoly N) => D p)
    (gaussDer_bracket G c e)
  simp only [Derivation.commutator_apply] at h
  have hR : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) p
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) p := sum_smul_der_apply _ _ _
  rw [hR] at h
  calc (gaussGenPoly G c * gaussGenPoly G e - gaussGenPoly G e * gaussGenPoly G c) p
      = (gaussDer G c) ((gaussDer G e) p) - (gaussDer G e) ((gaussDer G c) p) := rfl
    _ = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) p := h
    _ = (∑ h, (G.f c e h) • gaussGenPoly G h) p := by
        rw [LinearMap.sum_apply]
        exact Finset.sum_congr rfl fun h _ => by
          simp [gaussGenPoly]

/-- **The Gauss-law constraint** `𝒢_c` on the graded state space. -/
def gaussGen (c : Fin N) : Module.End ℂ (BookState N) := bosOpN (gaussGenPoly G c)

theorem gaussGen_bracket (c e : Fin N) :
    gaussGen G c * gaussGen G e - gaussGen G e * gaussGen G c
      = ∑ h, (G.f c e h) • gaussGen G h := by
  rw [gaussGen, gaussGen, ← bosOpN_mul, ← bosOpN_mul, ← bosOpN_sub, gaussGenPoly_bracket,
    bosOpN_sum]
  exact Finset.sum_congr rfl fun h _ => bosOpN_rsmul _ _

/-- The action of a Gauss-law generator on an arbitrary polynomial. -/
theorem gaussDer_apply (c : Fin N) (p : FieldPoly N) :
    gaussDer G c p = ∑ i : Fin 4 × Fin N, gaussVec G c i * pderiv i p := by
  classical
  induction p using MvPolynomial.induction_on with
  | C a =>
      rw [show (C a : FieldPoly N) = algebraMap ℂ (FieldPoly N) a from rfl,
        Derivation.map_algebraMap]
      simp
  | add p q hp hq =>
      rw [map_add, hp, hq, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun i _ => by rw [map_add, mul_add]
  | mul_X p i hp =>
      rw [Derivation.leibniz, hp, gaussDer_X]
      have hstep : ∀ j : Fin 4 × Fin N,
          gaussVec G c j * pderiv j (p * X i)
            = gaussVec G c j * pderiv j p * X i + (if j = i then gaussVec G c j * p else 0) := by
        intro j
        rw [Derivation.leibniz, MvPolynomial.pderiv_X]
        by_cases h : j = i
        · subst h
          simp [mul_add, mul_comm, mul_left_comm]
          ring
        · simp [h, mul_comm, mul_left_comm]
      rw [Finset.sum_congr rfl fun j _ => hstep j, Finset.sum_add_distrib,
        Finset.sum_ite_eq' Finset.univ i (fun j => gaussVec G c j * p)]
      simp only [Finset.mem_univ, if_pos, smul_eq_mul, Finset.mul_sum]
      rw [add_comm]
      congr 1
      · exact Finset.sum_congr rfl fun x _ => by ring
      · ring

/-- Leibniz rule against a coordinate. -/
theorem pderiv_X_mul (i j : Fin 4 × Fin N) (p : FieldPoly N) :
    (pderiv i : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X j * p)
      = (if i = j then p else 0) + X j * pderiv i p := by
  classical
  rw [Derivation.leibniz]
  simp only [MvPolynomial.pderiv_X, Pi.single_apply]
  by_cases h : i = j
  · subst h; simp; ring
  · rw [if_neg h, if_neg (fun hc => h hc.symm)]
    simp

/-- The Gauss-law constraint written with the book's momenta and gauge fields:
`𝒢_c = −i(π^μ_a ∂_μT_c|_a − f_{abc} π^μ_a A_{μb})`, i.e. `−i` times the coefficient of the
ghost `ψ†_c` in the book's charge. -/
theorem gaussGenPoly_eq (c : Fin N) :
    gaussGenPoly G c = (-Complex.I) •
      ((∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • momPoly μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b))) := by
  classical
  refine LinearMap.ext fun p => ?_
  have hL : gaussGenPoly G c p = ∑ μ, ∑ a, gaussVec G c (μ, a) * pderiv (μ, a) p := by
    have h0 : gaussGenPoly G c p = gaussDer G c p := rfl
    rw [h0, gaussDer_apply]
    exact Fintype.sum_prod_type _
  have hterm : ∀ (μ : Fin 4) (a : Fin N),
      gaussVec G c (μ, a) * pderiv (μ, a) p
        = (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) • momPoly μ a) p
            - ∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p) := by
    intro μ a
    have hb : ∀ b : Fin N,
        (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p
          = ((G.f a b c : ℝ) : ℂ) • ((-Complex.I) •
              ((if (μ, a) = (μ, b) then p else 0) + X (μ, b) * pderiv (μ, a) p)) := by
      intro b
      simp only [LinearMap.smul_apply, Module.End.mul_apply, AfieldPoly_apply, momPoly_apply,
        pderiv_X_mul]
    have hdiag : ((G.f a a c : ℝ) : ℂ) = 0 := by
      have : G.f a a c = 0 := by
        have h := G.antisymm a a c
        linarith
      rw [this]
      simp
    have hsum : (∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p)
        = ∑ b, ((G.f a b c : ℝ) : ℂ) • ((-Complex.I) • (X (μ, b) * pderiv (μ, a) p)) := by
      rw [Finset.sum_congr rfl fun b _ => hb b]
      refine Finset.sum_congr rfl fun b _ => ?_
      by_cases h : a = b
      · subst h
        rw [hdiag]
        simp
      · have h' : ¬ ((μ, a) = (μ, b)) := by
          intro hc
          exact h (congrArg Prod.snd hc)
        rw [if_neg h']
        simp
    rw [hsum]
    simp only [LinearMap.smul_apply, momPoly_apply, gaussVec, vecComb, smul_smul]
    rw [add_mul, Finset.sum_mul]
    simp only [smul_mul_assoc, one_mul, Complex.ofReal_neg]
    rw [smul_sub, Finset.smul_sum]
    have hIz : ∀ z : ℂ, -Complex.I * (z * -Complex.I) = -z := fun z => by
      linear_combination z * Complex.I_sq
    have hx : ∀ x : Fin N,
        (-Complex.I) • ((((G.f a x c : ℝ) : ℂ) * -Complex.I) • (X (μ, x) * pderiv (μ, a) p))
          = -((((G.f a x c : ℝ) : ℂ)) • (X (μ, x) * pderiv (μ, a) p)) := by
      intro x
      rw [smul_smul, hIz, neg_smul]
    have hd0 : (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) * -Complex.I) • (pderiv (μ, a) p))
        = -((((G.D μ c a : ℝ) : ℂ)) • (pderiv (μ, a) p)) := by
      rw [smul_smul, hIz, neg_smul]
    rw [hd0, Finset.sum_congr rfl fun x _ => hx x, Finset.sum_neg_distrib, sub_neg_eq_add,
      neg_smul]
  have hR : ((-Complex.I) •
      ((∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • momPoly μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)))) p
      = ∑ μ, ∑ a, (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) • momPoly μ a) p
          - ∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p) := by
    simp only [LinearMap.smul_apply, LinearMap.sub_apply, LinearMap.sum_apply, smul_sub,
      Finset.smul_sum, ← Finset.sum_sub_distrib]
  rw [hL, hR]
  exact Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => hterm μ a

/-! ## 6. The book's BRST charge -/

/-- `∂_μψ†_a`, the `a`-component of the spacetime derivative of the ghost field. -/
def dChi (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) :=
  ∑ b, (G.D μ b a) • chiOp b

/-- **The BRST charge of `book.tex`**,
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc} A_{μb} ψ†_c − (i/2) f_{abc} ψ†_a ψ†_b ψ_c`. -/
def bookOmega : Module.End ℂ (BookState N) :=
  (∑ μ, ∑ a, mom μ a * dChi G μ a)
    - (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c))
    - (Complex.I / 2) • (∑ a, ∑ b, ∑ c, (G.f a b c) • (chiOp a * chiOp b * betaOp c))

/-- The book's charge is `i` times the abstract BRST charge with the Gauss-law constraints;
in particular the book's coefficient `−i/2` of the cubic ghost term is exactly the one that
nilpotency requires. -/
theorem rsmul_eq_csmul (r : ℝ) (T : Module.End ℂ (BookState N)) :
    r • T = ((r : ℝ) : ℂ) • T := by
  refine LinearMap.ext fun x => ?_
  simp only [LinearMap.smul_apply]
  exact (algebraMap_smul ℂ r (T x)).symm

theorem bosOpN_sum2 (T : Fin 4 → Fin N → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ μ, ∑ a, T μ a) = ∑ μ, ∑ a, bosOpN (T μ a) := by
  rw [bosOpN_sum]
  exact Finset.sum_congr rfl fun μ _ => bosOpN_sum _

theorem bosOpN_sum3 (T : Fin 4 → Fin N → Fin N → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ μ, ∑ a, ∑ b, T μ a b) = ∑ μ, ∑ a, ∑ b, bosOpN (T μ a b) := by
  rw [bosOpN_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [bosOpN_sum]
  exact Finset.sum_congr rfl fun a _ => bosOpN_sum _

/-- `i` times the Gauss-law constraint, written with the book's momenta and gauge fields. -/
theorem I_smul_gaussGen (c : Fin N) :
    Complex.I • gaussGen G c
      = (∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • mom μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b)) := by
  have hI : Complex.I * (-Complex.I) = 1 := by
    simp [Complex.I_mul_I]
  rw [gaussGen, gaussGenPoly_eq, bosOpN_smul, smul_smul, hI, one_smul, bosOpN_sub]
  congr 1
  · rw [bosOpN_sum2]
    refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => ?_
    rw [bosOpN_smul, mom]
  · rw [bosOpN_sum3]
    refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ =>
      Finset.sum_congr rfl fun b _ => ?_
    rw [bosOpN_smul, bosOpN_mul, mom, Afield]

set_option maxHeartbeats 1600000 in
-- The proof expands a triple sum of operator products, whose `noncomm_ring` normalisation
-- exceeds the default heartbeat budget.
theorem bookOmega_eq_brstCharge :
    bookOmega G = Complex.I • brstCharge G.f (gaussGen G) chiOp betaOp := by
  have hglin : Complex.I • glin (gaussGen G) chiOp
      = (∑ μ, ∑ a, mom μ a * dChi G μ a)
        - (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c)) := by
    have h1 : Complex.I • glin (gaussGen G) chiOp
        = ∑ c, (Complex.I • gaussGen G c) * chiOp c := by
      rw [glin, Finset.smul_sum]
      exact Finset.sum_congr rfl fun c _ => (smul_mul_assoc _ _ _).symm
    rw [h1]
    have h2 : ∀ c : Fin N, (Complex.I • gaussGen G c) * chiOp c
        = (∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))
          - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c)) := by
      intro c
      rw [I_smul_gaussGen, sub_mul]
      congr 1
      · rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun μ _ => ?_
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun a _ => smul_mul_assoc _ _ _
      · rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun μ _ => ?_
        rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun b _ => smul_mul_assoc _ _ _
    rw [Finset.sum_congr rfl fun c _ => h2 c, Finset.sum_sub_distrib]
    congr 1
    · -- the derivative term
      have hT1 : (∑ μ, ∑ a, mom μ a * dChi G μ a)
          = ∑ μ, ∑ a, ∑ c, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c) := by
        refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => ?_
        rw [dChi, Finset.mul_sum]
        refine Finset.sum_congr rfl fun c _ => ?_
        rw [rsmul_eq_csmul, mul_smul_comm]
      rw [hT1]
      rw [Finset.sum_comm (f := fun c μ => ∑ a, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))]
      refine Finset.sum_congr rfl fun μ _ => ?_
      exact Finset.sum_comm (f := fun c a => ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))
    · -- the cubic-i
```

This module builds that charge: the three terms above, with the momenta, gauge-field
multiplication operators and ghosts realized as operators on a concrete graded state space,
and it *derives* the constraint algebra — the Gauss law — from the canonical relations
instead of assuming it.

## The gauge algebra and the derivative term

The book's gauge field takes values in the Lie algebra of the gauge group at every point of
space.  Here the local gauge algebra is modelled by a finite-dimensional Lie algebra `𝔤`
(basis `T_a`, `a : Fin N`, structure constants `f_{abc}` totally antisymmetric, as for the
book's `SU(N)` generators normalized by `tr(T_aT_b) = ½δ_{ab}`) carrying, for each spacetime
direction `μ`, a **derivation** `∂_μ` (matrix `D μ`).  The derivation property
`∂_μ[X,Y] = [∂_μX,Y] + [X,∂_μY]` is exactly what makes the first term `π^μ_a ∂_μψ†_a` of the
book's charge enter the Gauss-law algebra correctly.  `∂_μ = 0` is the constant
(single-multiplet) case; `∂_μ = ad_{X_μ}` is a non-trivial instance, exhibited below.

## What is proved

* `bookCCR`, `bookGhostCar` — the canonical (anti)commutation relations of the book's section
  hold in the realization: `[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`, `{ψ_a, ψ†_b} = δ_{ab}`, and the
  bosonic and ghost operators commute.
* `gaussGen_bracket` — **the Gauss-law constraint algebra**: the operators `𝒢_c` appearing as
  the coefficient of the ghost `ψ†_c` in the book's charge close into the gauge algebra,
  `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`.  This is *derived* from the canonical relations, the
  derivation property of `∂_μ` and the Jacobi identity.
* `bookOmega_eq_brstCharge` — the book's charge is `i` times the abstract BRST charge of
  `BookProof.QuantumGravityBrstCharge` with these constraints; in particular the coefficient
  `−i/2` of the cubic ghost term of `book.tex` is exactly the one nilpotency requires.
* **`bookOmega_nilpotent`** — `Ω² = 0` for the book's charge.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.BookBrstYangMills

open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

/-! ## 1. The gauge algebra with its spacetime derivations -/

/-- The data of the book's gauge algebra: totally antisymmetric structure constants obeying
the Jacobi identity (the `SU(N)` structure constants of the book's §"Pure SU(3) Yang-Mills
theory"), together with the four spacetime derivations `∂_μ` in the same basis,
`∂_μ T_a = Σ_b (D μ)_{ab} T_b`. -/
structure GaugeAlgebra (N : ℕ) where
  /-- structure constants, `[T_a, T_b] = Σ_c f_{abc} T_c` -/
  f : Fin N → Fin N → Fin N → ℝ
  /-- antisymmetry in the first two indices -/
  antisymm : ∀ a b c, f a b c = -f b a c
  /-- cyclic invariance; together with `antisymm` this is total antisymmetry, which is what
  the book's normalization `tr(T_aT_b) = ½δ_{ab}` provides -/
  cyclic : ∀ a b c, f a b c = f b c a
  /-- the Jacobi identity -/
  jacobi : ∀ a b c d, ∑ e, (f a b e * f e c d + f b c e * f e a d + f c a e * f e b d) = 0
  /-- the spacetime derivatives in the basis: `∂_μ T_a = Σ_b (D μ)_{ab} T_b` -/
  D : Fin 4 → Fin N → Fin N → ℝ
  /-- `∂_μ` is a derivation: `∂_μ[T_a,T_b] = [∂_μT_a, T_b] + [T_a, ∂_μT_b]` -/
  leibniz : ∀ μ a b c, ∑ h, f a b h * D μ h c
    = ∑ h, D μ a h * f h b c + ∑ h, D μ b h * f a h c

variable {N : ℕ} (G : GaugeAlgebra N)

/-! ## 2. Two index identities of the gauge algebra -/

/-- The contracted product of two structure constants. -/
def strProd (p q r s : Fin N) : ℝ := ∑ m, G.f p q m * G.f r s m

theorem strProd_symm (p q r s : Fin N) : strProd G p q r s = strProd G r s p q :=
  Finset.sum_congr rfl fun _ _ => mul_comm _ _

theorem strProd_swap12 (p q r s : Fin N) : strProd G p q r s = -strProd G q p r s := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm p q m]; ring

theorem strProd_swap34 (p q r s : Fin N) : strProd G p q r s = -strProd G p q s r := by
  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm r s m]; ring

/-- The Jacobi identity in contracted form. -/
theorem strProd_jacobi (x y z w : Fin N) :
    strProd G x y z w + strProd G y z x w + strProd G z x y w = 0 := by
  have h := G.jacobi x y z w
  rw [← h]
  simp only [strProd]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [G.cyclic m z w, G.cyclic m x w, G.cyclic m y w]

/-- **Constant part of the Gauss-law closure**: the derivation property of `∂_μ`. -/
theorem gauss_const_identity (μ : Fin 4) (a c e : Fin N) :
    (∑ b, G.f a b e * (-(G.D μ c b))) - (∑ b, G.f a b c * (-(G.D μ e b)))
      = ∑ h, G.f c e h * (-(G.D μ h a)) := by
  have hl := G.leibniz μ c e a
  have e1 : ∀ h : Fin N, G.D μ c h * G.f h e a = G.f a h e * G.D μ c h := by
    intro h
    have : G.f h e a = G.f a h e := by rw [G.cyclic h e a, G.cyclic e a h]
    rw [this, mul_comm]
  have e2 : ∀ h : Fin N, G.D μ e h * G.f c h a = -(G.f a h c * G.D μ e h) := by
    intro h
    have : G.f c h a = -G.f a h c := by rw [G.cyclic c h a, G.antisymm h a c]
    rw [this]; ring
  have hR : ∑ h, G.f c e h * (-(G.D μ h a)) = -(∑ h, G.f c e h * G.D μ h a) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => by ring
  have s1 : ∑ b, G.f a b e * (-(G.D μ c b)) = -(∑ b, G.f a b e * G.D μ c b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s2 : ∑ b, G.f a b c * (-(G.D μ e b)) = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  have s3 : ∑ h, G.D μ c h * G.f h e a = ∑ b, G.f a b e * G.D μ c b :=
    Finset.sum_congr rfl fun h _ => e1 h
  have s4 : ∑ h, G.D μ e h * G.f c h a = -(∑ b, G.f a b c * G.D μ e b) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun h _ => e2 h
  rw [hR, hl, s1, s2, s3, s4]
  ring

/-- **Field-dependent part of the Gauss-law closure**: the Jacobi identity. -/
theorem gauss_field_identity (a c e g : Fin N) :
    (∑ b, G.f a b e * G.f b g c) - (∑ b, G.f a b c * G.f b g e)
      = ∑ h, G.f c e h * G.f a g h := by
  have t1 : (∑ b, G.f a b e * G.f b g c) = strProd G e a g c := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b e, G.cyclic b e a, G.cyclic b g c]
  have t2 : (∑ b, G.f a b c * G.f b g e) = strProd G c a g e := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [G.cyclic a b c, G.cyclic b c a, G.cyclic b g e]
  have t3 : (∑ h, G.f c e h * G.f a g h) = strProd G c e a g := rfl
  rw [t1, t2, t3]
  have J1 := strProd_jacobi G e a g c
  have J2 := strProd_jacobi G c a g e
  have J3 := strProd_jacobi G a c g e
  have r1 : strProd G a g e c = -strProd G a g c e := strProd_swap34 G a g e c
  have r2 : strProd G g e a c = strProd G a c g e := strProd_symm G g e a c
  have r3 : strProd G g c a e = -strProd G c g a e := strProd_swap12 G g c a e
  have r4 : strProd G g a c e = -strProd G a g c e := strProd_swap12 G g a c e
  have r5 : strProd G c e a g = strProd G a g c e := strProd_symm G c e a g
  rw [r5]
  linarith [J1, J2, J3, r1, r2, r3, r4]

/-! ## 3. The state space: fields and ghosts -/

/-- The bosonic field coordinates: one polynomial variable per gauge-field component
`A_{μa}`. -/
abbrev FieldPoly (N : ℕ) : Type := MvPolynomial (Fin 4 × Fin N) ℂ

/-- The ghost sector: the `ℤ₂^N` occupation space `Λ(ℂ^N)`, one ghost per gauge generator. -/
abbrev GhostSpace (N : ℕ) : Type := ExteriorAlgebra ℂ (Fin N → ℂ)

/-- The graded state space of the book's section: bosonic fields tensored with ghosts. -/
abbrev BookState (N : ℕ) : Type := TensorProduct ℂ (FieldPoly N) (GhostSpace N)

/-- The ghost creation operator `ψ†_a`. -/
def ghostCreN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  LinearMap.mulLeft ℂ (ExteriorAlgebra.ι ℂ (Pi.single a 1))

/-- The ghost annihilation operator `ψ_a`. -/
def ghostAnnN (a : Fin N) : Module.End ℂ (GhostSpace N) :=
  CliffordAlgebra.contractLeft (LinearMap.proj a)

theorem ghostN_car : GhostCAR (ghostCreN (N := N)) (ghostAnnN (N := N)) := by
  constructor
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.mulLeft_apply,
      LinearMap.zero_apply, ← mul_assoc]
    rw [← add_mul, CliffordAlgebra.ι_mul_ι_add_swap]
    simp [QuadraticMap.polar]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostAnnN, LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply]
    rw [CliffordAlgebra.contractLeft_comm, neg_add_cancel]
  · intro a b
    refine LinearMap.ext fun x => ?_
    simp only [ghostCreN, ghostAnnN, LinearMap.add_apply, Module.End.mul_apply,
      LinearMap.mulLeft_apply, CliffordAlgebra.contractLeft_ι_mul]
    by_cases h : a = b
    · subst h; simp
    · simp [h]

/-- A bosonic operator on the graded space. -/
def bosOpN (T : Module.End ℂ (FieldPoly N)) : Module.End ℂ (BookState N) :=
  LinearMap.rTensor (GhostSpace N) T

/-- A ghost operator on the graded space. -/
def ghostOpN (T : Module.End ℂ (GhostSpace N)) : Module.End ℂ (BookState N) :=
  LinearMap.lTensor (FieldPoly N) T

theorem bosOpN_mul (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S * T) = bosOpN S * bosOpN T := by
  simp [bosOpN, Module.End.mul_eq_comp, LinearMap.rTensor_comp]

theorem bosOpN_sub (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S - T) = bosOpN S - bosOpN T := by simp [bosOpN]

theorem bosOpN_one : bosOpN (1 : Module.End ℂ (FieldPoly N)) = 1 := by
  simp [bosOpN, Module.End.one_eq_id, LinearMap.rTensor_id]

theorem bosOpN_zero : bosOpN (0 : Module.End ℂ (FieldPoly N)) = 0 := by simp [bosOpN]

theorem bosOpN_smul (r : ℂ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by
  refine LinearMap.ext fun x => ?_
  induction x using TensorProduct.induction_on with
  | zero => simp
  | tmul a b => simp [bosOpN, TensorProduct.smul_tmul']
  | add x y hx hy => simp [hx, hy]

theorem bosOpN_rsmul (r : ℝ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by
  have h1 : (r : ℝ) • T = ((r : ℂ)) • T := by
    ext p
    simp [Complex.real_smul]
  have h2 : ((r : ℂ)) • bosOpN T = (r : ℝ) • bosOpN T := by
    ext x
    first
      | exact algebraMap_smul ℂ r (bosOpN T _)
      | exact (algebraMap_smul ℂ r (bosOpN T _)).symm
      | rfl
  rw [h1, bosOpN_smul, h2]

theorem bosOpN_sum {n : ℕ} (T : Fin n → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ e, T e) = ∑ e, bosOpN (T e) :=
  map_sum (LinearMap.rTensorHom (R := ℂ) (GhostSpace N)) T Finset.univ

theorem ghostOpN_mul (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S * T) = ghostOpN S * ghostOpN T := by
  simp [ghostOpN, Module.End.mul_eq_comp, LinearMap.lTensor_comp]

theorem ghostOpN_add (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S + T) = ghostOpN S + ghostOpN T := by simp [ghostOpN]

theorem ghostOpN_one : ghostOpN (1 : Module.End ℂ (GhostSpace N)) = 1 := by
  simp [ghostOpN, Module.End.one_eq_id, LinearMap.lTensor_id]

theorem ghostOpN_zero : ghostOpN (0 : Module.End ℂ (GhostSpace N)) = 0 := by simp [ghostOpN]

theorem bosOpN_ghostOpN_comm (S : Module.End ℂ (FieldPoly N)) (T : Module.End ℂ (GhostSpace N)) :
    bosOpN S * ghostOpN T = ghostOpN T * bosOpN S := by
  simp [bosOpN, ghostOpN, Module.End.mul_eq_comp, LinearMap.lTensor_comp_rTensor,
    LinearMap.rTensor_comp_lTensor]

/-- The ghost creation operator `ψ†_a` on the graded space. -/
def chiOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostCreN a)

/-- The ghost annihilation operator `ψ_a` on the graded space. -/
def betaOp (a : Fin N) : Module.End ℂ (BookState N) := ghostOpN (ghostAnnN a)

/-- **The ghosts of the book's section obey the canonical anticommutation relations.** -/
theorem bookGhostCar : GhostCAR (chiOp (N := N)) (betaOp (N := N)) := by
  classical
  constructor
  · intro a b
    rw [chiOp, chiOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).chichi a b, ghostOpN_zero]
  · intro a b
    rw [betaOp, betaOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).betabeta a b, ghostOpN_zero]
  · intro a b
    rw [betaOp, chiOp, ← ghostOpN_mul, ← ghostOpN_mul, ← ghostOpN_add,
      (ghostN_car (N := N)).betachi a b]
    by_cases h : a = b
    · simp [h, ghostOpN_one]
    · simp [h, ghostOpN_zero]

/-! ## 4. The gauge field and its conjugate momentum -/

/-- The gauge-field operator `A_{μa}` on the polynomial core: multiplication by the
coordinate. -/
def AfieldPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  LinearMap.mulLeft ℂ (X (μ, a))

/-- The conjugate momentum `π^μ_a = −i ∂/∂A_{μa}` on the polynomial core. -/
def momPoly (μ : Fin 4) (a : Fin N) : Module.End ℂ (FieldPoly N) :=
  (-Complex.I) • (pderiv (μ, a) : Derivation ℂ (FieldPoly N) (FieldPoly N)).toLinearMap

/-- The gauge-field operator on the graded space. -/
def Afield (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (AfieldPoly μ a)

/-- The conjugate momentum on the graded space. -/
def mom (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) := bosOpN (momPoly μ a)

theorem momPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    momPoly μ a p = (-Complex.I) • (pderiv (μ, a) p) := rfl

theorem AfieldPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    AfieldPoly μ a p = X (μ, a) * p := rfl

/-- **The canonical commutation relation of the book's section** on the polynomial core:
`[A_{μa}, π^ν_b] = i δ^ν_μ δ_{ab}`. -/
theorem bookCCR_poly (μ ν : Fin 4) (a b : Fin N) :
    AfieldPoly μ a * momPoly ν b - momPoly ν b * AfieldPoly μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (FieldPoly N)) else 0 := by
  classical
  refine LinearMap.ext fun p => ?_
  have hd : (pderiv (ν, b) : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X (μ, a) * p)
      = (if (ν, b) = (μ, a) then p else 0) + X (μ, a) * pderiv (ν, b) p := by
    rw [Derivation.leibniz]
    simp only [MvPolynomial.pderiv_X, Pi.single_apply]
    by_cases h : (ν, b) = (μ, a)
    · rw [if_pos h, if_pos h.symm]
      simp [add_comm]
    · rw [if_neg h, if_neg (fun hc => h hc.symm)]
      simp
  by_cases h : (μ, a) = (ν, b)
  · have h' : (ν, b) = (μ, a) := h.symm
    simp only [if_pos h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_pos h', LinearMap.smul_apply, Module.End.one_apply, smul_add,
      mul_smul_comm]
    rw [h]
    simp
  · have h' : ¬ (ν, b) = (μ, a) := fun hc => h hc.symm
    simp only [if_neg h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_neg h', LinearMap.zero_apply, zero_add, 
      mul_smul_comm]
    simp

/-- **The canonical commutation relation** on the graded state space. -/
theorem bookCCR (μ ν : Fin 4) (a b : Fin N) :
    Afield μ a * mom ν b - mom ν b * Afield μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (BookState N)) else 0 := by
  classical
  rw [Afield, mom, ← bosOpN_mul, ← bosOpN_mul, ← bosOpN_sub, bookCCR_poly]
  by_cases h : (μ, a) = (ν, b)
  · rw [if_pos h, if_pos h, bosOpN_smul, bosOpN_one]
  · rw [if_neg h, if_neg h, bosOpN_zero]

/-- The bosonic operators commute with the ghosts. -/
theorem Afield_comm_chi (μ : Fin 4) (a b : Fin N) :
    Afield (N := N) μ a * chiOp b = chiOp b * Afield μ a := bosOpN_ghostOpN_comm _ _

theorem mom_comm_chi (μ : Fin 4) (a b : Fin N) :
    mom (N := N) μ a * chiOp b = chiOp b * mom μ a := bosOpN_ghostOpN_comm _ _

/-! ## 5. The Gauss-law constraints -/

/-- An affine combination `α·1 + Σ_g β_g A_{μg}` of the field coordinates in one spacetime
direction: the shape of an infinitesimal gauge transformation of `A_{μa}`. -/
def vecComb (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) : FieldPoly N :=
  ((α : ℝ) : ℂ) • (1 : FieldPoly N) + ∑ g, ((β g : ℝ) : ℂ) • X (μ, g)

theorem vecComb_sub (α α' : ℝ) (β β' : Fin N → ℝ) (μ : Fin 4) :
    vecComb α β μ - vecComb α' β' μ = vecComb (α - α') (fun g => β g - β' g) μ := by
  simp only [vecComb, Complex.ofReal_sub, sub_smul, Finset.sum_sub_distrib]
  abel

theorem vecComb_sum {n : ℕ} (κ : Fin n → ℝ) (α : Fin n → ℝ) (β : Fin n → Fin N → ℝ)
    (μ : Fin 4) :
    (∑ h, ((κ h : ℝ) : ℂ) • vecComb (α h) (β h) μ)
      = vecComb (∑ h, κ h * α h) (fun g => ∑ h, κ h * β h g) μ := by
  simp only [vecComb, smul_add, Finset.smul_sum, smul_smul, ← Complex.ofReal_mul]
  rw [Finset.sum_add_distrib, ← Finset.sum_smul, ← Complex.ofReal_sum]
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun g _ => ?_
  rw [← Finset.sum_smul, ← Complex.ofReal_sum]

/-- The coefficient polynomials of the Gauss-law vector field: (minus) the infinitesimal gauge
transformation of the coordinate `A_{μa}` generated by `T_c`. -/
def gaussVec (c : Fin N) : (Fin 4 × Fin N) → FieldPoly N := fun i =>
  vecComb (-(G.D i.1 c i.2)) (fun g => G.f i.2 g c) i.1

/-- The Gauss-law generator as a derivation of the field algebra. -/
def gaussDer (c : Fin N) : Derivation ℂ (FieldPoly N) (FieldPoly N) :=
  mkDerivation ℂ (gaussVec G c)

@[simp] theorem gaussDer_X (c : Fin N) (i : Fin 4 × Fin N) :
    gaussDer G c (X i) = gaussVec G c i := mkDerivation_X ℂ _ i

/-- The action of a Gauss-law generator on an affine combination of coordinates. -/
theorem gaussDer_vecComb (c : Fin N) (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) :
    gaussDer G c (vecComb α β μ)
      = vecComb (∑ b, β b * (-(G.D μ c b))) (fun g => ∑ b, β b * G.f b g c) μ := by
  have h1 : gaussDer G c (((α : ℝ) : ℂ) • (1 : FieldPoly N)) = 0 := by
    rw [Derivation.map_smul_of_tower, Derivation.map_one_eq_zero, smul_zero]
  have h2 : gaussDer G c (∑ g, ((β g : ℝ) : ℂ) • X (μ, g))
      = ∑ g, ((β g : ℝ) : ℂ) • gaussVec G c (μ, g) := by
    rw [map_sum]
    exact Finset.sum_congr rfl fun g _ => by
      rw [Derivation.map_smul_of_tower, gaussDer_X]
  rw [vecComb, map_add, h1, h2, zero_add]
  simpa [gaussVec] using vecComb_sum (N := N) β (fun b => -(G.D μ c b))
    (fun b g => G.f b g c) μ

/-- Applying a linear combination of derivations. -/
theorem sum_smul_der_apply {n : ℕ} (k : Fin n → ℂ)
    (D : Fin n → Derivation ℂ (FieldPoly N) (FieldPoly N)) (p : FieldPoly N) :
    (∑ h, k h • D h) p = ∑ h, k h • (D h) p := by
  classical
  induction (Finset.univ : Finset (Fin n)) using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Derivation.add_apply,
        Derivation.smul_apply, ih]

/-- **The Gauss-law constraints close into the gauge algebra** (as derivations of the field
algebra): `[𝒢_c, 𝒢_e] = Σ_h f_{ceh} 𝒢_h`. -/
theorem gaussDer_bracket (c e : Fin N) :
    ⁅gaussDer G c, gaussDer G e⁆
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h := by
  refine MvPolynomial.derivation_ext fun i => ?_
  obtain ⟨μ, a⟩ := i
  have hsum : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) (X (μ, a))
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • gaussVec G h (μ, a) := by
    have hstep : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) (X (μ, a))
        = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) (X (μ, a)) :=
      sum_smul_der_apply _ _ _
    rw [hstep]
    exact Finset.sum_congr rfl fun h _ => by rw [gaussDer_X]
  rw [Derivation.commutator_apply, hsum, gaussDer_X, gaussDer_X, gaussVec, gaussVec,
    gaussDer_vecComb, gaussDer_vecComb, vecComb_sub]
  have hR : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussVec G h (μ, a))
      = vecComb (∑ h, G.f c e h * (-(G.D μ h a)))
          (fun g => ∑ h, G.f c e h * G.f a g h) μ := by
    simpa [gaussVec] using vecComb_sum (N := N) (fun h => G.f c e h)
      (fun h => -(G.D μ h a)) (fun h g => G.f a g h) μ
  rw [hR]
  congr 1
  · exact gauss_const_identity G μ a c e
  · funext g
    exact gauss_field_identity G a c e g

/-- **The Gauss-law constraint** `𝒢_c` on the polynomial core. -/
def gaussGenPoly (c : Fin N) : Module.End ℂ (FieldPoly N) := (gaussDer G c).toLinearMap

theorem gaussGenPoly_bracket (c e : Fin N) :
    gaussGenPoly G c * gaussGenPoly G e - gaussGenPoly G e * gaussGenPoly G c
      = ∑ h, (G.f c e h) • gaussGenPoly G h := by
  refine LinearMap.ext fun p => ?_
  have h := congrArg (fun D : Derivation ℂ (FieldPoly N) (FieldPoly N) => D p)
    (gaussDer_bracket G c e)
  simp only [Derivation.commutator_apply] at h
  have hR : (∑ h, ((G.f c e h : ℝ) : ℂ) • gaussDer G h) p
      = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) p := sum_smul_der_apply _ _ _
  rw [hR] at h
  calc (gaussGenPoly G c * gaussGenPoly G e - gaussGenPoly G e * gaussGenPoly G c) p
      = (gaussDer G c) ((gaussDer G e) p) - (gaussDer G e) ((gaussDer G c) p) := rfl
    _ = ∑ h, ((G.f c e h : ℝ) : ℂ) • (gaussDer G h) p := h
    _ = (∑ h, (G.f c e h) • gaussGenPoly G h) p := by
        rw [LinearMap.sum_apply]
        exact Finset.sum_congr rfl fun h _ => by
          simp [gaussGenPoly]

/-- **The Gauss-law constraint** `𝒢_c` on the graded state space. -/
def gaussGen (c : Fin N) : Module.End ℂ (BookState N) := bosOpN (gaussGenPoly G c)

theorem gaussGen_bracket (c e : Fin N) :
    gaussGen G c * gaussGen G e - gaussGen G e * gaussGen G c
      = ∑ h, (G.f c e h) • gaussGen G h := by
  rw [gaussGen, gaussGen, ← bosOpN_mul, ← bosOpN_mul, ← bosOpN_sub, gaussGenPoly_bracket,
    bosOpN_sum]
  exact Finset.sum_congr rfl fun h _ => bosOpN_rsmul _ _

/-- The action of a Gauss-law generator on an arbitrary polynomial. -/
theorem gaussDer_apply (c : Fin N) (p : FieldPoly N) :
    gaussDer G c p = ∑ i : Fin 4 × Fin N, gaussVec G c i * pderiv i p := by
  classical
  induction p using MvPolynomial.induction_on with
  | C a =>
      rw [show (C a : FieldPoly N) = algebraMap ℂ (FieldPoly N) a from rfl,
        Derivation.map_algebraMap]
      simp
  | add p q hp hq =>
      rw [map_add, hp, hq, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun i _ => by rw [map_add, mul_add]
  | mul_X p i hp =>
      rw [Derivation.leibniz, hp, gaussDer_X]
      have hstep : ∀ j : Fin 4 × Fin N,
          gaussVec G c j * pderiv j (p * X i)
            = gaussVec G c j * pderiv j p * X i + (if j = i then gaussVec G c j * p else 0) := by
        intro j
        rw [Derivation.leibniz, MvPolynomial.pderiv_X]
        by_cases h : j = i
        · subst h
          simp [mul_add, mul_comm, mul_left_comm]
          ring
        · simp [h, mul_comm, mul_left_comm]
      rw [Finset.sum_congr rfl fun j _ => hstep j, Finset.sum_add_distrib,
        Finset.sum_ite_eq' Finset.univ i (fun j => gaussVec G c j * p)]
      simp only [Finset.mem_univ, if_pos, smul_eq_mul, Finset.mul_sum]
      rw [add_comm]
      congr 1
      · exact Finset.sum_congr rfl fun x _ => by ring
      · ring

/-- Leibniz rule against a coordinate. -/
theorem pderiv_X_mul (i j : Fin 4 × Fin N) (p : FieldPoly N) :
    (pderiv i : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X j * p)
      = (if i = j then p else 0) + X j * pderiv i p := by
  classical
  rw [Derivation.leibniz]
  simp only [MvPolynomial.pderiv_X, Pi.single_apply]
  by_cases h : i = j
  · subst h; simp; ring
  · rw [if_neg h, if_neg (fun hc => h hc.symm)]
    simp

/-- The Gauss-law constraint written with the book's momenta and gauge fields:
`𝒢_c = −i(π^μ_a ∂_μT_c|_a − f_{abc} π^μ_a A_{μb})`, i.e. `−i` times the coefficient of the
ghost `ψ†_c` in the book's charge. -/
theorem gaussGenPoly_eq (c : Fin N) :
    gaussGenPoly G c = (-Complex.I) •
      ((∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • momPoly μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b))) := by
  classical
  refine LinearMap.ext fun p => ?_
  have hL : gaussGenPoly G c p = ∑ μ, ∑ a, gaussVec G c (μ, a) * pderiv (μ, a) p := by
    have h0 : gaussGenPoly G c p = gaussDer G c p := rfl
    rw [h0, gaussDer_apply]
    exact Fintype.sum_prod_type _
  have hterm : ∀ (μ : Fin 4) (a : Fin N),
      gaussVec G c (μ, a) * pderiv (μ, a) p
        = (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) • momPoly μ a) p
            - ∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p) := by
    intro μ a
    have hb : ∀ b : Fin N,
        (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p
          = ((G.f a b c : ℝ) : ℂ) • ((-Complex.I) •
              ((if (μ, a) = (μ, b) then p else 0) + X (μ, b) * pderiv (μ, a) p)) := by
      intro b
      simp only [LinearMap.smul_apply, Module.End.mul_apply, AfieldPoly_apply, momPoly_apply,
        pderiv_X_mul]
    have hdiag : ((G.f a a c : ℝ) : ℂ) = 0 := by
      have : G.f a a c = 0 := by
        have h := G.antisymm a a c
        linarith
      rw [this]
      simp
    have hsum : (∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p)
        = ∑ b, ((G.f a b c : ℝ) : ℂ) • ((-Complex.I) • (X (μ, b) * pderiv (μ, a) p)) := by
      rw [Finset.sum_congr rfl fun b _ => hb b]
      refine Finset.sum_congr rfl fun b _ => ?_
      by_cases h : a = b
      · subst h
        rw [hdiag]
        simp
      · have h' : ¬ ((μ, a) = (μ, b)) := by
          intro hc
          exact h (congrArg Prod.snd hc)
        rw [if_neg h']
        simp
    rw [hsum]
    simp only [LinearMap.smul_apply, momPoly_apply, gaussVec, vecComb, smul_smul]
    rw [add_mul, Finset.sum_mul]
    simp only [smul_mul_assoc, one_mul, Complex.ofReal_neg]
    rw [smul_sub, Finset.smul_sum]
    have hIz : ∀ z : ℂ, -Complex.I * (z * -Complex.I) = -z := fun z => by
      linear_combination z * Complex.I_sq
    have hx : ∀ x : Fin N,
        (-Complex.I) • ((((G.f a x c : ℝ) : ℂ) * -Complex.I) • (X (μ, x) * pderiv (μ, a) p))
          = -((((G.f a x c : ℝ) : ℂ)) • (X (μ, x) * pderiv (μ, a) p)) := by
      intro x
      rw [smul_smul, hIz, neg_smul]
    have hd0 : (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) * -Complex.I) • (pderiv (μ, a) p))
        = -((((G.D μ c a : ℝ) : ℂ)) • (pderiv (μ, a) p)) := by
      rw [smul_smul, hIz, neg_smul]
    rw [hd0, Finset.sum_congr rfl fun x _ => hx x, Finset.sum_neg_distrib, sub_neg_eq_add,
      neg_smul]
  have hR : ((-Complex.I) •
      ((∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • momPoly μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)))) p
      = ∑ μ, ∑ a, (-Complex.I) • ((((G.D μ c a : ℝ) : ℂ) • momPoly μ a) p
          - ∑ b, (((G.f a b c : ℝ) : ℂ) • (momPoly μ a * AfieldPoly μ b)) p) := by
    simp only [LinearMap.smul_apply, LinearMap.sub_apply, LinearMap.sum_apply, smul_sub,
      Finset.smul_sum, ← Finset.sum_sub_distrib]
  rw [hL, hR]
  exact Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => hterm μ a

/-! ## 6. The book's BRST charge -/

/-- `∂_μψ†_a`, the `a`-component of the spacetime derivative of the ghost field. -/
def dChi (μ : Fin 4) (a : Fin N) : Module.End ℂ (BookState N) :=
  ∑ b, (G.D μ b a) • chiOp b

/-- **The BRST charge of `book.tex`**,
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc} A_{μb} ψ†_c − (i/2) f_{abc} ψ†_a ψ†_b ψ_c`. -/
def bookOmega : Module.End ℂ (BookState N) :=
  (∑ μ, ∑ a, mom μ a * dChi G μ a)
    - (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c))
    - (Complex.I / 2) • (∑ a, ∑ b, ∑ c, (G.f a b c) • (chiOp a * chiOp b * betaOp c))

/-- The book's charge is `i` times the abstract BRST charge with the Gauss-law constraints;
in particular the book's coefficient `−i/2` of the cubic ghost term is exactly the one that
nilpotency requires. -/
theorem rsmul_eq_csmul (r : ℝ) (T : Module.End ℂ (BookState N)) :
    r • T = ((r : ℝ) : ℂ) • T := by
  refine LinearMap.ext fun x => ?_
  simp only [LinearMap.smul_apply]
  exact (algebraMap_smul ℂ r (T x)).symm

theorem bosOpN_sum2 (T : Fin 4 → Fin N → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ μ, ∑ a, T μ a) = ∑ μ, ∑ a, bosOpN (T μ a) := by
  rw [bosOpN_sum]
  exact Finset.sum_congr rfl fun μ _ => bosOpN_sum _

theorem bosOpN_sum3 (T : Fin 4 → Fin N → Fin N → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ μ, ∑ a, ∑ b, T μ a b) = ∑ μ, ∑ a, ∑ b, bosOpN (T μ a b) := by
  rw [bosOpN_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [bosOpN_sum]
  exact Finset.sum_congr rfl fun a _ => bosOpN_sum _

/-- `i` times the Gauss-law constraint, written with the book's momenta and gauge fields. -/
theorem I_smul_gaussGen (c : Fin N) :
    Complex.I • gaussGen G c
      = (∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • mom μ a)
        - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b)) := by
  have hI : Complex.I * (-Complex.I) = 1 := by
    simp [Complex.I_mul_I]
  rw [gaussGen, gaussGenPoly_eq, bosOpN_smul, smul_smul, hI, one_smul, bosOpN_sub]
  congr 1
  · rw [bosOpN_sum2]
    refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => ?_
    rw [bosOpN_smul, mom]
  · rw [bosOpN_sum3]
    refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ =>
      Finset.sum_congr rfl fun b _ => ?_
    rw [bosOpN_smul, bosOpN_mul, mom, Afield]

set_option maxHeartbeats 1600000 in
-- The proof expands a triple sum of operator products, whose `noncomm_ring` normalisation
-- exceeds the default heartbeat budget.
theorem bookOmega_eq_brstCharge :
    bookOmega G = Complex.I • brstCharge G.f (gaussGen G) chiOp betaOp := by
  have hglin : Complex.I • glin (gaussGen G) chiOp
      = (∑ μ, ∑ a, mom μ a * dChi G μ a)
        - (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c)) := by
    have h1 : Complex.I • glin (gaussGen G) chiOp
        = ∑ c, (Complex.I • gaussGen G c) * chiOp c := by
      rw [glin, Finset.smul_sum]
      exact Finset.sum_congr rfl fun c _ => (smul_mul_assoc _ _ _).symm
    rw [h1]
    have h2 : ∀ c : Fin N, (Complex.I • gaussGen G c) * chiOp c
        = (∑ μ, ∑ a, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))
          - (∑ μ, ∑ a, ∑ b, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c)) := by
      intro c
      rw [I_smul_gaussGen, sub_mul]
      congr 1
      · rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun μ _ => ?_
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun a _ => smul_mul_assoc _ _ _
      · rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun μ _ => ?_
        rw [Finset.sum_mul]
        refine Finset.sum_congr rfl fun a _ => ?_
        rw [Finset.sum_mul]
        exact Finset.sum_congr rfl fun b _ => smul_mul_assoc _ _ _
    rw [Finset.sum_congr rfl fun c _ => h2 c, Finset.sum_sub_distrib]
    congr 1
    · -- the derivative term
      have hT1 : (∑ μ, ∑ a, mom μ a * dChi G μ a)
          = ∑ μ, ∑ a, ∑ c, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c) := by
        refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ => ?_
        rw [dChi, Finset.mul_sum]
        refine Finset.sum_congr rfl fun c _ => ?_
        rw [rsmul_eq_csmul, mul_smul_comm]
      rw [hT1]
      rw [Finset.sum_comm (f := fun c μ => ∑ a, ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))]
      refine Finset.sum_congr rfl fun μ _ => ?_
      exact Finset.sum_comm (f := fun c a => ((G.D μ c a : ℝ) : ℂ) • (mom μ a * chiOp c))
    · -- the cubic-in-fields term
      have hT2 : (∑ μ, ∑ a, ∑ b, ∑ c, (G.f a b c) • (mom μ a * Afield μ b * chiOp c))
          = ∑ μ, ∑ a, ∑ b, ∑ c, ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c) := by
        refine Finset.sum_congr rfl fun μ _ => Finset.sum_congr rfl fun a _ =>
          Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => ?_
        rw [rsmul_eq_csmul]
      rw [hT2]
      rw [Finset.sum_comm (f := fun c μ => ∑ a, ∑ b,
        ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c))]
      refine Finset.sum_congr rfl fun μ _ => ?_
      rw [Finset.sum_comm (f := fun c a => ∑ b,
        ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c))]
      refine Finset.sum_congr rfl fun a _ => ?_
      exact Finset.sum_comm (f := fun c b =>
        ((G.f a b c : ℝ) : ℂ) • (mom μ a * Afield μ b * chiOp c))
  have hQ : Complex.I • ((1 / 2 : ℝ) • Q G.f (chiOp (N := N)) betaOp)
      = (Complex.I / 2) • (∑ a, ∑ b, ∑ c, (G.f a b c) • (chiOp a * chiOp b * betaOp c)) := by
    rw [Q, rsmul_eq_csmul, smul_smul]
    congr 1
    push_cast
    ring
  rw [bookOmega, brstCharge, smul_sub, hglin, hQ]


theorem bookConstraintAlgebra : ConstraintAlgebra G.f (gaussGen G) chiOp betaOp where
  comm_chi _ _ := bosOpN_ghostOpN_comm _ _
  comm_beta _ _ := bosOpN_ghostOpN_comm _ _
  bracket a b := gaussGen_bracket G a b

/-- **The BRST charge of `book.tex` is nilpotent**: `Ω² = 0`. -/
theorem bookOmega_nilpotent : bookOmega G * bookOmega G = 0 := by
  have hnil : brstCharge G.f (gaussGen G) chiOp betaOp * brstCharge G.f (gaussGen G) chiOp betaOp
      = 0 :=
    brst_full_nilpotent bookGhostCar (bookConstraintAlgebra G) G.antisymm
      (fun a b c d => G.jacobi a b c d)
  rw [bookOmega_eq_brstCharge, smul_mul_smul_comm, hnil, smul_zero]

end

end BookProof.BookBrstYangMills
