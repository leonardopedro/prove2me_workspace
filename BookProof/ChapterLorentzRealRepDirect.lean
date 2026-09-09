import Mathlib
import BookProof.ChapterLorentzRealRep
import BookProof.ChapterLorentzRealRepSum
import BookProof.ChapterLorentzRealRepFull

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups", **Lemma 52** — the four
representation spaces form an *internal direct sum*

Continuing `BookProof.ChapterLorentzRealRep`, `ChapterLorentzRealRepSum` and
`ChapterLorentzRealRepFull` (`book.tex` Lemma 52, line ~5560), which built the
four mutually Frobenius-orthogonal real representation spaces

* `WHalf` — the `(1/2,1/2)` vector representation (dimension `4`),
* `W10`   — the `(1,0)` representation (dimension `6`),
* `WPs`   — the pseudo-`(1/2,1/2)` representation (dimension `4`),
* `WTwo`  — the two discrete Majorana directions `span{iγ⁰, γ⁰γ⁵}` (dimension `2`),

and proved that their fourfold sup is *all* of `Matrix (Fin 4) (Fin 4) ℝ`
(`decomposition_top`) with `16 = 4 + 6 + 4 + 2` (`finrank_full_eq_add`).

Those earlier files certified the *internal direct sum* only through a dimension
count.  This file upgrades that to the genuine structural statement:
`DirectSum.IsInternal` of the family `WFam = ![WHalf, W10, WPs, WTwo]`, i.e. the
canonical map `⨁ᵢ WFam i → Matrix (Fin 4) (Fin 4) ℝ` is an isomorphism.  From it
we read off the two defining properties of an internal direct sum:

* **spanning** `iSup_WFam_eq_top` (`⨆ i, WFam i = ⊤`);
* **independence** `WFam_iSupIndep` (`iSupIndep WFam`);

and the headline `WFam_isInternal`.

The proof is the finite-dimensional bijectivity argument: the canonical map
`DirectSum.coeLinearMap WFam` is surjective (its range is `⨆ i, WFam i = ⊤`) and
its domain `⨁ᵢ WFam i` has dimension `∑ᵢ finrank (WFam i) = 16 = finrank of the
whole matrix algebra`, so a surjection between equidimensional finite spaces is a
bijection.

As requested this stays **off the gravity line** and **off the Hankel-transform
line** (only the Majorana representation spaces of the previous waves are used).

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix Module

namespace BookProof.ChapterLorentzRealRepDirect

open BookProof.ChapterLorentzRealRep BookProof.ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepFull

/-- The family of the four real representation subspaces of `SL(2,ℂ)` inside the
`16`-dimensional matrix algebra. -/
noncomputable def WFam : Fin 4 → Submodule ℝ (Matrix (Fin 4) (Fin 4) ℝ) :=
  ![WHalf, W10, WPs, WTwo]

/-
The fourfold supremum of the family is the whole matrix algebra.
-/
theorem iSup_WFam_eq_top : (⨆ i, WFam i) = ⊤ := by
  convert BookProof.ChapterLorentzRealRepFull.decomposition_top using 1;
  refine le_antisymm ?_ ?_;
  · refine iSup_le ?_;
    intro i; fin_cases i <;> simp only [WFam, Fin.zero_eta, Fin.isValue, cons_val_zero, Fin.mk_one,
        cons_val_one, Fin.reduceFinMk, cons_val, le_sup_right] ;
    · exact le_sup_of_le_left ( le_sup_of_le_left ( le_sup_of_le_left le_rfl ) );
    · exact le_sup_of_le_left ( le_sup_of_le_left ( le_sup_right ) );
    · exact le_sup_of_le_left ( le_sup_of_le_right le_rfl );
  · simp only [iSup, WFam, range_cons, range_empty, Set.union_empty, Set.union_singleton,
      Set.union_insert, sSup_insert, sSup_singleton, sup_le_iff, le_sup_left, and_true];
    exact ⟨ ⟨ le_sup_of_le_right <| le_sup_of_le_right <| le_sup_of_le_right le_rfl,
        le_sup_of_le_right <| le_sup_of_le_right <| le_sup_of_le_left le_rfl ⟩, le_sup_of_le_right
            <| le_sup_of_le_left le_rfl ⟩

/-
The dimensions of the four summands add up to the dimension of the whole
matrix algebra (`4 + 6 + 4 + 2 = 16`).
-/
theorem sum_finrank_WFam :
    (∑ i, finrank ℝ (WFam i)) = finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ) := by
  convert BookProof.ChapterLorentzRealRepFull.finrank_full_eq_add.symm;
  convert Fin.sum_univ_four _

/-
**Internal direct sum.**  The four mutually orthogonal representation spaces
form an internal direct sum of the whole matrix algebra: the canonical map
`⨁ᵢ WFam i → Matrix (Fin 4) (Fin 4) ℝ` is an isomorphism.
-/
theorem WFam_isInternal : DirectSum.IsInternal WFam := by
  refine ⟨ ?_, ?_ ⟩;
  · intro x y hxy;
    have h_inj : Function.Injective (DirectSum.coeLinearMap WFam) := by
      have h_surj : LinearMap.range (DirectSum.coeLinearMap WFam) = ⊤ := by
        rw [ DirectSum.range_coeLinearMap ];
        convert iSup_WFam_eq_top using 1;
      have h_finrank : Module.finrank ℝ (DirectSum (Fin 4) fun i => WFam i) = Module.finrank ℝ
          (Matrix (Fin 4) (Fin 4) ℝ) := by
        convert sum_finrank_WFam using 1;
        convert Module.finrank_directSum ℝ ( fun i => WFam i );
      have h_inj : LinearMap.ker (DirectSum.coeLinearMap WFam) = ⊥ := by
        have := LinearMap.finrank_range_add_finrank_ker ( DirectSum.coeLinearMap WFam );
        rw [ h_surj, finrank_top ] at this ; aesop;
      exact LinearMap.ker_eq_bot.mp h_inj;
    exact h_inj hxy;
  · convert LinearMap.range_eq_top.mp ( show LinearMap.range ( DirectSum.coeLinearMap WFam ) = ⊤
      from ?_ ) using 1;
    rw [ DirectSum.range_coeLinearMap ];
    exact iSup_WFam_eq_top

/-- **Independence.**  The four representation spaces are supremum-independent. -/
theorem WFam_iSupIndep : iSupIndep WFam :=
  WFam_isInternal.submodule_iSupIndep

open BookProof.ChapterA3 BookProof.ChapterPinOmega in
/-- **The conjugation representation of `Ω` respects the decomposition.**  For
every `S ∈ Ω` and every index `i`, conjugation by `S` maps the `i`-th summand
`WFam i` into itself.  Together with `WFam_isInternal` this exhibits the
`16`-dimensional conjugation representation of the discrete Pin subgroup `Ω` as
the internal direct sum of the four subrepresentations `WHalf`, `W10`, `WPs`,
`WTwo`. -/
theorem WFam_conj_invariant (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) (i : Fin 4) :
    (WFam i).map (conjL (castR S) (castR (cinv S))) ≤ WFam i := by
  fin_cases i <;> simp only [WFam, 
    ]
  · exact WHalf_invariant S hS
  · exact W10_invariant S hS
  · exact WPs_invariant S hS
  · exact WTwo_invariant S hS

end BookProof.ChapterLorentzRealRepDirect
