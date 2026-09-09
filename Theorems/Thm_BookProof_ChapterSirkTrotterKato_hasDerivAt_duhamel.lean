-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_duhamel
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_duhamel (T S : UnboundedSelfAdjoint H) (chi : T.domain) (t u : ℝ) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (S.resCLM 1 (T.stoneU r (chi : H))))
      (Complex.I • S.stoneU (t - u)
        (T.resCLM 1 (T.stoneU u (T.shift 1 chi))
          - S.resCLM 1 (T.stoneU u (T.shift 1 chi)))) u := by sorry
