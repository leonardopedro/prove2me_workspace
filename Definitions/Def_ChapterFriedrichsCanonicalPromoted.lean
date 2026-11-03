-- Generated from ChapterFriedrichsCanonical.lean — two facts that the platform's
-- served ChapterFriedrichsCanonical copy predates (§2.13 new-name route:
-- submit-definition rejects an existing name, so the decls live here instead).
-- `resolvent_mem_friedrichsDomain` is the term proof the `friedrichsOp_resolvent`
-- statement carries as `⟨u, resolvent_mem_friedrichsDomain P u⟩`;
-- `qgScalaronPosSymOp_dense` the density hypothesis `friedrichs_canonical` /
-- `friedrichs_unique` need for the quantum-gravity instance.
import Definitions.Def_ChapterFriedrichsCanonical
import Mathlib

namespace BookProof.FriedrichsCanonical

open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- The form resolvent lands in the Friedrichs domain, by construction. -/
theorem resolvent_mem_friedrichsDomain (P : PosSymOp F) (u : F) :
    friedrichsResolvent P u ∈ friedrichsDomain P := ⟨u, rfl⟩

open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.HermiteProductCore

/-- The Gauss–polynomial core is dense, so the scalaron operator has dense domain. -/
theorem qgScalaronPosSymOp_dense (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) :
    Dense (((qgScalaronPosSymOp M alpha hM halpha).dom : Submodule ℂ (L2d 1)) : Set (L2d 1)) :=
  polyGaussCore_dense

end

end BookProof.FriedrichsCanonical
