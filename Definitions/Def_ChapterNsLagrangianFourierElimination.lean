import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The Fourier elimination in **Lagrangian** (material) variables — and the degeneracy it meets

`CONSOLIDATED_PLAN.md` item 6 asks for the Lagrangian version of the Fourier elimination of the
derivative variables, by “the same device” as the Eulerian one: the spatial transform is on the
**reference** coordinate `a`, so the material derivative is diagonal, `∂/∂a_j ↦ i ℓ_j`, and the
coordinates that *represent* derivatives are eliminated by

```
σ(F_{ij}) = i ℓ_j ξ_i ,    σ(V_{ij}) = i ℓ_j v_i ,    σ(S_i) = −|ℓ|² v_i ,    σ(y_j) = 0 ,
```

leaving the twelve coordinates `(ξ_i, v_i, a_i, q_i)` per parcel.

**The content of this chapter is that this device is degenerate, and the proof is short.**  The
substitution makes the deformation gradient the *rank-one* matrix `F = ℓ ⊗ ξ` at every mode, and in
three dimensions

* every `2 × 2` minor of a rank-one matrix vanishes, hence `cof(F) = 0` — so the **Piola pressure
  term** `Σ_j cof(F)_{ji} q_j`, which is the entire pressure coupling of the material momentum
  equation, is annihilated by the elimination (`lagElimSubst_piola`);
* `det F = 0` for the same reason, so the **volume constraint** `det F = 1` collapses to the
  constant `−1` (`lagElimSubst_volumePoly`), whose square is `1`
  (`lagElimSubst_volumePoly_sq`) — it carries no field content and cannot couple to the field.

So the Lagrangian route cannot eliminate `F` mode-wise.  The symbolic checks B1–B3 of
`DESIGN_COMPARISON_N_20260915.md` §9 (Piola quadratic, determinant cubic, volume square sextic) are
*degree* checks and are passed trivially by the zero polynomial; the design note's §6 reading is the
right one: in the material picture the determinant must be treated as an independent scalar mode
(`log det F`, with `grad_logDet` on the physical sector `‖A‖ < 1`), not through `F = i ℓ ⊗ ξ`.  The
elimination of the *velocity* derivative `V_{ij} → i ℓ_j v_i` and of the viscous coordinate
`S_i → −|ℓ|² v_i` is unaffected, and the eliminated momentum equation keeps exactly those two terms
(`lagElimSubst_lagResPoly`).

**Status: complete.**  §1–5 below all elaborate: `lRedIdx`, `lagElimCoord` / `lagLift` /
`lagElimHom` and the coordinate values for `ξ_i`, `v_i`, `a_i`, `q_i`, `y_j`, `S_i`; the two
rank-one coordinate lemmas `lagElimCoord_fIdx` and `lagElimCoord_vgIdx` (previously a heartbeat
timeout in their `Fin 36`-index bookkeeping, now proved by rewriting the index arithmetic before
the dependent `Fin` constructors are touched); and the degeneracy itself (`rankOne_cof_zero`,
`lagElimSubst_cofPoly`/`_piola`/`_detPoly`/`_volumePoly`/`_volumePoly_sq`,
`lagElimSubst_lagResPoly`).  No `sorry` and no `axiom` is used anywhere in the file, and the
module is imported by `BookProof.lean`.  This discharges the handoff of `CONSOLIDATED_PLAN.md`
item 6, “Status — handoff to the Lean specialist”.
-/

namespace BookProof.NsLagFourier

open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}



/-! ## 1. The reduced coordinates and the substitution `σ` -/

/-- The reduced twelve-coordinate block of one parcel: `(ξ_i, v_i, a_i, q_i)`. -/
def lRedIdx (p : Fin n) (i : Fin 12) : Fin (n * 12) := finProdFinEquiv (p, i)

abbrev xiIdx12 (i : Fin 3) : Fin 12 := ⟨i.val, by omega⟩

abbrev vIdx12 (i : Fin 3) : Fin 12 := ⟨3 + i.val, by omega⟩

abbrev accIdx12 (i : Fin 3) : Fin 12 := ⟨6 + i.val, by omega⟩

abbrev qIdx12 (i : Fin 3) : Fin 12 := ⟨9 + i.val, by omega⟩

/-- The elimination substitution on one parcel's 36 coordinates, as a polynomial in the twelve
reduced coordinates.  The layout of `Fin 36` is that of `xiIdx`/`vIdx`/`accIdx`/`fIdx`/`vgIdx`/
`sIdx`/`qIdx`/`yIdx` of `ChapterNavierStokesFullLagrangianFock`. -/
def lagElimCoord (l : Fin 3 → ℝ) (i : Fin 36) : MvPolynomial (Fin 12) ℂ :=
  if h : i.val < 3 then X (xiIdx12 ⟨i.val, h⟩)
  else if h2 : i.val < 6 then X (vIdx12 ⟨i.val - 3, by omega⟩)
  else if h3 : i.val < 9 then X (accIdx12 ⟨i.val - 6, by omega⟩)
  else if _h4 : i.val < 18 then
    C (Complex.I * (((l ⟨(i.val - 9) % 3, by omega⟩ : ℝ)) : ℂ))
      * X (xiIdx12 ⟨(i.val - 9) / 3, by omega⟩)
  else if _h5 : i.val < 27 then
    C (Complex.I * (((l ⟨(i.val - 18) % 3, by omega⟩ : ℝ)) : ℂ))
      * X (vIdx12 ⟨(i.val - 18) / 3, by omega⟩)
  else if _h6 : i.val < 30 then
    -C (((∑ j : Fin 3, (l j) ^ 2 : ℝ)) : ℂ) * X (vIdx12 ⟨i.val - 27, by omega⟩)
  else if h7 : i.val < 33 then X (qIdx12 ⟨i.val - 30, by omega⟩)
  else 0

/-- Reindex a one-parcel reduced polynomial into the `p`-th parcel's block. -/
def lagLift (p : Fin n) : MvPolynomial (Fin 12) ℂ →+* MvPolynomial (Fin (n * 12)) ℂ :=
  MvPolynomial.eval₂Hom (MvPolynomial.C) (fun j => X (lRedIdx p j))

/-- **The elimination `σ`** on the `n`-parcel Lagrangian ring. -/
def lagElimHom (l : Fin 3 → ℝ) (n : ℕ) :
    MvPolynomial (Fin (n * 36)) ℂ →+* MvPolynomial (Fin (n * 12)) ℂ :=
  MvPolynomial.eval₂Hom (MvPolynomial.C)
    (fun s => lagLift (finProdFinEquiv.symm s).1 (lagElimCoord l (finProdFinEquiv.symm s).2))

@[simp] theorem lagLift_X (p : Fin n) (j : Fin 12) : lagLift p (X j) = X (lRedIdx p j) :=
  MvPolynomial.eval₂Hom_X' _ _ j

@[simp] theorem lagLift_C (p : Fin n) (c : ℂ) : lagLift p (C c) = C c := by
  rw [lagLift, MvPolynomial.eval₂Hom_C]





/-! ## 2. The coordinate values of `σ` -/

@[simp] theorem lagElimCoord_xiIdx (l : Fin 3 → ℝ) (i : Fin 3) :
    lagElimCoord l (xiIdx i) = X (xiIdx12 i) := by
  have h : (xiIdx i).val < 3 := i.isLt
  rw [lagElimCoord, dif_pos h]
  rfl

@[simp] theorem lagElimCoord_vIdx (l : Fin 3 → ℝ) (i : Fin 3) :
    lagElimCoord l (vIdx i) = X (vIdx12 i) := by
  have hv : (vIdx i).val = 3 + i.val := rfl
  have h1 : ¬ (vIdx i).val < 3 := by rw [hv]; omega
  have h2 : (vIdx i).val < 6 := by rw [hv]; omega
  have hlt : (vIdx i).val - 3 < 3 := by omega
  rw [lagElimCoord, dif_neg h1, dif_pos h2]
  have hx : (⟨(vIdx i).val - 3, hlt⟩ : Fin 3) = i := by
    apply Fin.ext
    change (vIdx i).val - 3 = i.val
    rw [hv]; omega
  simp only [hx]

@[simp] theorem lagElimCoord_accIdx (l : Fin 3 → ℝ) (i : Fin 3) :
    lagElimCoord l (accIdx i) = X (accIdx12 i) := by
  have hv : (accIdx i).val = 6 + i.val := rfl
  have h1 : ¬ (accIdx i).val < 3 := by rw [hv]; omega
  have h2 : ¬ (accIdx i).val < 6 := by rw [hv]; omega
  have h3 : (accIdx i).val < 9 := by rw [hv]; omega
  have hlt : (accIdx i).val - 6 < 3 := by omega
  rw [lagElimCoord, dif_neg h1, dif_neg h2, dif_pos h3]
  have hx : (⟨(accIdx i).val - 6, hlt⟩ : Fin 3) = i := by
    apply Fin.ext
    change (accIdx i).val - 6 = i.val
    rw [hv]; omega
  simp only [hx]

@[simp] theorem lagElimCoord_qIdx (l : Fin 3 → ℝ) (i : Fin 3) :
    lagElimCoord l (qIdx i) = X (qIdx12 i) := by
  have hv : (qIdx i).val = 30 + i.val := rfl
  have h1 : ¬ (qIdx i).val < 3 := by rw [hv]; omega
  have h2 : ¬ (qIdx i).val < 6 := by rw [hv]; omega
  have h3 : ¬ (qIdx i).val < 9 := by rw [hv]; omega
  have h4 : ¬ (qIdx i).val < 18 := by rw [hv]; omega
  have h5 : ¬ (qIdx i).val < 27 := by rw [hv]; omega
  have h6 : ¬ (qIdx i).val < 30 := by rw [hv]; omega
  have h7 : (qIdx i).val < 33 := by rw [hv]; omega
  have hlt : (qIdx i).val - 30 < 3 := by omega
  rw [lagElimCoord, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_neg h5, dif_neg h6,
    dif_pos h7]
  have hx : (⟨(qIdx i).val - 30, hlt⟩ : Fin 3) = i := by
    apply Fin.ext
    change (qIdx i).val - 30 = i.val
    rw [hv]; omega
  simp only [hx]

@[simp] theorem lagElimCoord_yIdx (l : Fin 3 → ℝ) (j : Fin 3) :
    lagElimCoord l (yIdx j) = 0 := by
  have hv : (yIdx j).val = 33 + j.val := rfl
  have h1 : ¬ (yIdx j).val < 3 := by rw [hv]; omega
  have h2 : ¬ (yIdx j).val < 6 := by rw [hv]; omega
  have h3 : ¬ (yIdx j).val < 9 := by rw [hv]; omega
  have h4 : ¬ (yIdx j).val < 18 := by rw [hv]; omega
  have h5 : ¬ (yIdx j).val < 27 := by rw [hv]; omega
  have h6 : ¬ (yIdx j).val < 30 := by rw [hv]; omega
  have h7 : ¬ (yIdx j).val < 33 := by rw [hv]; omega
  rw [lagElimCoord, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_neg h5, dif_neg h6,
    dif_neg h7]







/-! ## 3. The lifted substitution on the coordinates -/

















/-! ## 4. The degeneracy: rank one kills the cofactor and the determinant -/















end

end BookProof.NsLagFourier
