-- Generated from ChapterQgOuterFockOneParticle.lean — 
theorem BookProof.QgOuterFockOneParticle.secHam_eq_sum_oneParticle (x : secCore (ι := ι)) (a : ι) :
    (secHam W Q x : Sec ι) a
      = ∑ b ∈ insert a (Q.nbr a), oneParticleOp W Q a b (fibOf x b) := by sorry
