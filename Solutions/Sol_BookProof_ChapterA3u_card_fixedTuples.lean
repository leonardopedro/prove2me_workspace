-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.card_fixedTuples
import Mathlib
import Definitions.Def_ChapterA3u
import Theorems.Thm_BookProof_ChapterA3u_invariant_sameCycle
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    (Finset.univ.filter (fun a : Idx N => a ∘ σ = a)).card
      = 4 ^ ((N - σ.cycleType.sum) + σ.cycleType.card) := by

  -- Let's simplify the goal using the fact that multiplication by a constant out of the exponent
  -- results in the same exponent.
  set c := (N - σ.cycleType.sum + σ.cycleType.card) with hc_def
  have h_card : (Finset.univ.filter (fun a : Fin N → Fin 4 => a ∘ σ = a)).card = 4 ^ c := by
    have h_card : (Finset.univ.filter (fun a : Fin N → Fin 4 => a ∘ σ = a)).card = Fintype.card {a :
        Fin N → Fin 4 // a ∘ σ = a} := by
      rw [ Fintype.subtype_card ];
    rw [ h_card ];
    convert Fintype.card_congr ( show { a : Fin N → Fin 4 // a ∘ σ = a } ≃ ( { x : Fin N // σ x = x
        } ⊕ { c : Equiv.Perm ( Fin N ) // c ∈ σ.cycleFactorsFinset } → Fin 4 ) from ?_ ) using 1;
    · simp? +zetaDelta at *;
      rw [ show Fintype.card { x // σ x = x } = N - σ.cycleType.sum from ?_, show
          σ.cycleFactorsFinset.card = σ.cycleType.card from ?_ ];
      · rw [ Equiv.Perm.cycleType_def ];
        simp [ Function.comp ];
      · have := Equiv.Perm.sum_cycleType σ; simp_all only [Fintype.card_subtype] ;
        rw [ show ( Finset.univ.filter fun x => σ x = x ) = Finset.univ \ σ.support from ?_,
            Finset.card_sdiff ] <;> aesop;
    · refine Equiv.ofBijective ( fun a => Sum.elim ( fun x => a.val x ) ( fun c => a.val (
        c.val.support.min' <| Finset.nonempty_of_ne_empty <| by
        intro h; have := c.2; simp_all [ Equiv.Perm.mem_cycleFactorsFinset_iff ] ; ) ) ) ⟨ ?_, ?_ ⟩
      all_goals generalize_proofs at *;
      · intro a b h; ext x; by_cases hx : σ x = x <;> simp_all only [funext_iff,
          Function.comp_apply, Sum.forall, Sum.elim_inl, Subtype.forall, Sum.elim_inr] ;
        have h_cycle : σ.cycleOf x ∈ σ.cycleFactorsFinset := by
          simp only [Equiv.Perm.mem_cycleFactorsFinset_iff, Equiv.Perm.mem_support, ne_eq];
          refine ⟨ ?_, ?_ ⟩
          all_goals generalize_proofs at *;
          · exact Equiv.Perm.isCycle_cycleOf _ hx;
          · simp [ Equiv.Perm.cycleOf_apply ];
            tauto
        generalize_proofs at *;
        have h_cycle_eq : σ.SameCycle x (σ.cycleOf x |>.support.min' <| Finset.nonempty_of_ne_empty
            <| by
          grind) := by
          have h_cycle_eq : ∀ y ∈ (σ.cycleOf x).support, σ.SameCycle x y := by
            intro y hy;              have := Equiv.Perm.mem_support.mp ( show y ∈ ( σ.cycleOf x
                ).support from by aesop ) ;              simp_all [ Equiv.Perm.mem_support,
                                  Equiv.Perm.cycleOf_apply ] ;
          generalize_proofs at *;
          exact h_cycle_eq _ <| Finset.min'_mem _ _
        generalize_proofs at *;
        grind +suggestions;
      · intro g;
        refine ⟨ ⟨ fun x => if hx : σ x = x then g ( Sum.inl ⟨ x, hx ⟩ ) else g ( Sum.inr ⟨
            σ.cycleOf x, ?_ ⟩ ), ?_ ⟩, ?_ ⟩ <;> simp_all only [funext_iff, Function.comp_apply,
                Subtype.forall, EmbeddingLike.apply_eq_iff_eq, Equiv.Perm.cycleOf_self_apply,
                    implies_true, Subtype.coe_eta, Sum.forall, Sum.elim_inl, dite_eq_left_iff,
                        not_true_eq_false, IsEmpty.forall_iff, Sum.elim_inr, true_and];
        all_goals generalize_proofs at *;
        · simp only [Equiv.Perm.mem_cycleFactorsFinset_iff, Equiv.Perm.mem_support, ne_eq];
          refine ⟨ ?_, ?_ ⟩;
          · exact Equiv.Perm.isCycle_cycleOf _ ( by aesop );
          · intro a ha; simp_all [ Equiv.Perm.cycleOf_apply ] ;
        · intro a ha; split_ifs <;> simp_all only [SetLike.coe_mem, implies_true,
            Equiv.Perm.mem_cycleFactorsFinset_iff, Equiv.Perm.mem_support, ne_eq, not_false_eq_true,
                and_self, forall_and_index] ;
          · have := Equiv.Perm.mem_cycleFactorsFinset_iff.mp ha; simp_all [ Equiv.Perm.IsCycle ] ;
            have := Finset.min'_mem ( a.support ) ; simp_all [ Equiv.Perm.mem_support ] ;
            grind;
          · congr! 2;
            exact Subtype.ext <| Equiv.Perm.mem_cycleFactorsFinset_iff.mp ha |>.2 |> fun h => by
              have h_cycle_eq : ∀ x ∈ a.support, σ.cycleOf x = a :=
                fun x hx => (Equiv.Perm.cycle_is_cycleOf hx ha).symm
              exact h_cycle_eq _ ( Finset.min'_mem _ <| by solve_by_elim );
  convert h_card using 1
